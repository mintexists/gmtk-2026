@tool
extends Node2D

@export var line_2d: Line2D

@export_multiline() var equation_string = ""

@export_tool_button("Random Equation") var draw_graph_button = draw_graph
@export_tool_button("Delete From List") var delete_from_list_button = func(): equations.pop_back()
#@export_tool_button("Clear Graph") var clear_graph_button = line_2d.clear_points

@export var equations: Array[String] = []

@export_tool_button("Play Back") var play_back_button;

func play_back():
	pass

func score(value, normal, min_result, max_result):
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal) / max_score

func draw_graph(equation):
	#var equation = Evaluator.parse_equation_string(equation_string)
	var results = Evaluator.get_all_possible_values(equation)
	var max_result = results[-1]
	var min_result = results[0]
	var normal_result = equation.evaluate("PEMDAS".split(""))

	line_2d.clear_points()
	for i in len(results):
		var size = Vector2(1152, 648)
		var x = remap(i, 0, len(results), 0, size.x)
		var score_value = score(results[i], normal_result, min_result, max_result)
		var y = remap(score_value, 0, 1, size.y, 0)
		line_2d.add_point(Vector2(x, y))
	equation_string = equation.to_string_ugly()
	equations.append(equation_string)
	pass
