extends "res://Scripts/Block.gd"

export (Array, NodePath) var copied_blocks 

func set_pos(val: Vector2):
	for block_path in copied_blocks:
		get_node(block_path).set_pos(val)
	.set_pos(val)
