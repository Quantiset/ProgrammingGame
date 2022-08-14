extends CodeNode

var temp_a := 0.0
var temp_b := 0.0

func _ready():
	help_info = "Runs the next node if the first input is equal to the second"

func _process(delta):
	if incoming_lines.has(0) and incoming_lines[0].get_value() != temp_a and incoming_lines[0].get_value() != null:
		temp_a = incoming_lines[0].get_value()
		$a.text = "a " + str(temp_a)
		if incoming_lines.has(1):
			check_if()
	
	if incoming_lines.has(1) and incoming_lines[1].get_value() != temp_b and incoming_lines[1].get_value() != null:
		temp_b = incoming_lines[1].get_value()
		$b.text = "b " + str(temp_b)
		if incoming_lines.has(0):
			check_if()

func check_if():
	if is_equal_approx(temp_a, temp_b) and outgoing_lines.has(0): 
		outgoing_lines[0].advance()
