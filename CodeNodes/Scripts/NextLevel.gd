extends CodeNode

signal activated()

func _ready():
	help_info = "When this node gets run, go to the next level"

func advance():
	emit_signal("activated")
	main.get_node("%StartButton").type = main.get_node("%StartButton").Types.NextLevel
