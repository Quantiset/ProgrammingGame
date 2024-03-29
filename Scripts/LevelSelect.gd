extends Control

func _ready():
	for i in range(Globals.save_dict.level):
		i += 1
		if not Globals.levels.has(i):
			break
		get_node("ColorRect/GridContainer/LevelSelectIcon"+str(i)).show()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
	$CanvasLayer/ParallaxLayer.motion_offset += Vector2(0.2, 0.5) * delta * 50


func _on_ExitButton_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
