extends CodeNode

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	$Position.text = str(get_value(0))

func get_value(arrow_idx: int):
	return selected_object.position / 80

func _process(delta):
	pass
