extends CodeNode


func _ready():
	help_info = "When this node gets run, go to the next level"

func advance():
	main.get_node("%StartButton").type = main.get_node("%StartButton").Types.NextLevel
