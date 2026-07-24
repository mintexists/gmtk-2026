@tool
extends Line2D

#@export_multiline() var equation_string = ""

@export_tool_button("Draw Graph") var draw_graph_button = draw_graph
@export_tool_button("Clear Graph") var clear_graph_button = clear_points

func score(value, normal, min_result, max_result):
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal) / max_score

func draw_graph():
	#var equation = Evaluator.parse_equation_string(equation_string)
	var equation = Parentheses.generate_random()
	var results = Evaluator.get_all_possible_values(equation)
	var max_result = results[-1]
	var min_result = results[0]
	var normal_result = equation.evaluate("PEMDAS".split(""))
	print(max_result)
	print(min_result)
	clear_points()
	for i in len(results):
		var size = Vector2(1152, 648)
		var x = remap(i, 0, len(results), 0, size.x)
		var score_value = score(results[i], normal_result, min_result, max_result)
		print(score_value)
		var y = remap(score_value, 0, 1, size.y, 0)
		#print(x, " ", y)
		add_point(Vector2(x, y))
	#print(results)
	#print(normal_result)
	pass
