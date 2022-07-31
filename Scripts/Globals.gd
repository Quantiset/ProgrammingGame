extends Node

const HALF_ARROW_OFFSET = Vector2(11, 14)
const TILE_SIZE = Vector2(80, 80)

var held_line

const SAVE_FILE := "user://data.save"
var SAVE_DICT := {
	"level": 1,
}
var save_dict := SAVE_DICT.duplicate()

var show_fps := false
var fps_label: Label

func _ready():
	var f := File.new()
	f.open(SAVE_FILE, f.READ_WRITE)
	var temp = f.get_var()
	if temp:
		save_dict = temp
	f.close()
	
	fps_label = Label.new()
	add_child(fps_label)

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		match event.button_index:
			BUTTON_RIGHT:
				if held_line: held_line.delete()

func _process(delta):
	
	if held_line and is_instance_valid(held_line):
		held_line.remove_point(1)
		held_line.add_point(held_line.get_local_mouse_position())
	
	if show_fps and fps_label:
		fps_label.text = str(Engine.get_frames_per_second())
	

func change_scene(scene: String):
	get_tree().change_scene(scene)

func set_level_complete(level: int):
	level += 1
	save_dict.level = max(level, save_dict.level)
	save()

func save():
	var f := File.new()
	f.open(SAVE_FILE, f.WRITE_READ)
	f.store_var(save_dict)
	f.close()
