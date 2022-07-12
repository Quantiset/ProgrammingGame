extends Control

func _ready():
	for i in range(Globals.save_dict.level):
		get_node("ColorRect/GridContainer/LevelSelectIcon"+str(i+1)).show()

func _process(delta):
	$CanvasLayer/ParallaxLayer.motion_offset += Vector2(0.2, 0.5) * delta * 50
