@tool
extends Node

@export_multiline() var equation_string = ""

@export_tool_button("Run") var run_button = run

func _ready() -> void:
	run()
	pass

func run():
	var order = ["P", "E", "M", "D", "A", "S"]
	var parsed = Evaluator.parse_equation_string(equation_string)
	#var parsed = Evaluator.parse_equation_string("1 + 2 + 3")
	print(parsed)
	print(parsed.evaluate(order))
	print(parsed.evaluate_to_depth(order, 6))
	#var start = Time.get_ticks_usec()
	#print(Evaluator.get_all_possible_values(parsed))
	#var end = Time.get_ticks_usec()
#	var worker_time = (end-start)
	#print(worker_time)
