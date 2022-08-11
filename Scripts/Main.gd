extends Node2D
class_name Main

const CAMERA_SPEED = 10

const ZOOM_MULTIPLICITY = 0.8
const MAX_ZOOM = 2
const MIN_ZOOM = 1

var is_mouse_held := false
var mouse_start_pos: Vector2

var process_parse := false

signal help_clicked


func _input(event):
	
	if event is InputEventMouseButton:
		match event.button_index:
			BUTTON_WHEEL_UP:
				$Camera2D.zoom *= ZOOM_MULTIPLICITY
			BUTTON_WHEEL_DOWN:
				$Camera2D.zoom /= ZOOM_MULTIPLICITY
			BUTTON_LEFT:
				is_mouse_held = event.is_pressed()
				mouse_start_pos = event.position
	
	if mouse_start_pos.x > $CanvasLayer/HSplitContainer/MarginContainer.get_global_rect().position.x:
		return
	
	if event is InputEventMouseMotion:
		if is_mouse_held:
			$Camera2D.position -= event.relative * $Camera2D.zoom
	
	$Camera2D.zoom = $Camera2D.zoom.clamped(MAX_ZOOM)


func _ready():
	
	$CanvasLayer/StartButton.show()
	$CanvasLayer/ResetButton.show()
	$CanvasLayer/MenuButton.show()
	
	if not GlobalAudioStream.playing:
		print("HI")
#		_on_AudioButton_pressed()
#		GlobalAudioStream.playing = false
	
	
	for code_node in get_tree().get_nodes_in_group("CodeNode"):
		code_node.selected_object = $Block
	


func _process(delta):
	
	$Camera2D.position.x += Input.get_axis("ui_left", "ui_right") * CAMERA_SPEED
	$Camera2D.position.y += Input.get_axis("ui_up", "ui_down") * CAMERA_SPEED
	
	$PositionIndicator.rect_position = get_local_mouse_position().snapped(Vector2(80, 80))
	$PositionIndicator.text = str((get_local_mouse_position() / 80).round())
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("ui_menu"):
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
	
	if process_parse:
		parse(false)
	


func _on_HSplitContainer_unhandled_input(event):
	_unhandled_input(event)

func code_node_connected(line):
	$CanvasLayer/StartButton/AnimationPlayer.play("dilate")

func _on_StartButton_pressed():
	if $CanvasLayer/StartButton.type == $CanvasLayer/StartButton.Types.NextLevel:
		Globals.set_level_complete(level_complete_idx)
		Globals.change_scene("res://Scenes/LevelSelect.tscn")
	if $CanvasLayer/StartButton.type == $CanvasLayer/StartButton.Types.Custom:
		for node in get_tree().get_nodes_in_group("CodeNode"):
			if node.has_method("start_logic_chain"):
				node.start_logic_chain()
		return
	parse()
	if $CanvasLayer/StartButton.type == $CanvasLayer/StartButton.Types.Process:
		process_parse = true

func parse(anim := true):
	for cnode in get_tree().get_nodes_in_group("Setter"):
		if cnode.has_method("parse"): 
			cnode.parse(anim)


func _on_ResetButton_pressed():
	get_tree().reload_current_scene()


func _on_MenuButton_pressed():
	get_tree().change_scene("res://Scenes/LevelSelect.tscn")


func _on_HelpButton_pressed():
	$CanvasLayer/HelpButton/ColorRect.visible = not \
			$CanvasLayer/HelpButton/ColorRect.visible
	emit_signal("help_clicked")

var level_complete_idx := 0
func set_level_complete(_level_complete_idx):
	level_complete_idx = _level_complete_idx
	$CanvasLayer/StartButton.type = $CanvasLayer/StartButton.Types.NextLevel

func _on_AudioButton_pressed():
	GlobalAudioStream.playing = not GlobalAudioStream.playing
	$CanvasLayer/AudioButton/TextureRect.texture = \
		preload("res://Assets/AudioX.png") if $CanvasLayer/AudioButton/TextureRect.texture == \
		preload("res://Assets/Audio.png") else preload("res://Assets/Audio.png")
