extends Node

const HALF_ARROW_OFFSET = Vector2(11, 14)
const TILE_SIZE = Vector2(80, 80)

var held_line

const SAVE_FILE := "user://data.save"
var SAVE_DICT := {
	"level": 1,
	"sandbox": false,
}
var save_dict := SAVE_DICT.duplicate()

var show_fps := false setget set_show_fps
var fps_label: Label

var current_level := 1
var levels := {
	1: {
		"name": "I - Introduction",
		"color": Color(1,1,1),
		"location": preload("res://Levels/Level1.tscn")
	},
	2: {
		"name": "II - Addition",
		"color": Color(0.933594, 0.81906, 0.200577),
		"location": preload("res://Levels/Level2.tscn")
	},
	3: {
		"name": "III - Component Addition",
		"color": Color(0.933594, 0.81906, 0.200577),
		"location": preload("res://Levels/Level3.tscn")
	},
	4: {
		"name": "IV - Vector Addition",
		"color": Color(0.933594, 0.81906, 0.200577),
		"location": preload("res://Levels/Level4.tscn")
	},
	5: {
		"name": "V - Seeing Doubles",
		"color": Color(0.933594, 0.81906, 0.200577),
		"location": preload("res://Levels/Level5.tscn")
	},
	6: {
		"name": "VI - Timing",
		"color": Color(0.921875, 0.480434, 0.126038),
		"location": preload("res://Levels/Level6.tscn")
	},
	7: {
		"name": "VII - Circular Reasoning",
		"color": Color(0.921875, 0.480434, 0.126038),
		"location": preload("res://Levels/Level7.tscn")
	},
	8: {
		"name": "VIII - Scaling",
		"color": Color(0.096466, 0.851562, 0.161357),
		"location": preload("res://Levels/Level8.tscn")
	},
	9: {
		"name": "IX - Circuit Building",
		"color": Color(0.264267, 0.510461, 0.980469),
		"location": preload("res://Levels/Level9.tscn")
	},
	10: {
		"name": "X - Rotational Woes",
		"color": Color(0.264267, 0.510461, 0.980469),
		"location": preload("res://Levels/Level10.tscn")
	},
	11: {
		"name": "XI - Ca-radian Arrest",
		"color": Color(0.921875, 0.480434, 0.126038),
		"location": preload("res://Levels/Level11.tscn")
	},
	12: {
		"name": "XII - Multifaceted Approaches",
		"color": Color(0.096466, 0.851562, 0.161357),
		"location": preload("res://Levels/Level12.tscn")
	},
	13: {
		"name": "XIII - Arrows??",
		"color": Color(0.941406, 0.136063, 0.136063),
		"location": preload("res://Levels/Level13.tscn")
	},
	14: {
		"name": "IXV - If true then win",
		"color": Color(0.941406, 0.136063, 0.136063),
		"location": preload("res://Levels/Level14.tscn")
	},
	15: {
		"name": "XV - Normalizing Progress",
		"color": Color(0.941406, 0.136063, 0.136063),
		"location": preload("res://Levels/Level15.tscn")
	},
	16: {
		"name": "XVI - Counterproductive Reasoning",
		"color": Color(0.941406, 0.136063, 0.136063),
		"location": preload("res://Levels/Level16.tscn")
	},
	17: {
		"name": "XVII - The Last Dot",
		"color": Color(1, 1, 1),
		"location": preload("res://Levels/Level17.tscn")
	},
}

func _ready():
	var f := File.new()
	f.open(SAVE_FILE, f.READ_WRITE)
	var temp = f.get_var()
	if temp:
		save_dict = temp
	f.close()
	
#	fps_label = Label.new()
#	add_child(fps_label)

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

func to_level(level: int):
	if not levels.has(level):
		get_tree().change_scene("res://Scenes/LevelSelect.tscn")
	
	current_level = level
	get_tree().change_scene_to(levels[level].location)

func set_level_complete(level: int):
	level += 1
	save_dict.level = max(level, save_dict.level)
	
	if not levels.has(level):
		save_dict.sandbox = true
	
	save()

func save():
	var f := File.new()
	f.open(SAVE_FILE, f.WRITE_READ)
	f.store_var(save_dict)
	f.close()

func set_show_fps(val):
	show_fps = val
	#fps_label.visible = val
