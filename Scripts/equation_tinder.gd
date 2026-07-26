@tool
extends Node2D

@export var line_2d: Line2D

@export var length = 5

@export_multiline() var equation_string = ""

@export_tool_button("Random Equation") var random_equation_button = generate_graph
@export_tool_button("Delete Last") var delete_from_list_button = delete_last_graph

#@export_tool_button("Play Back") var play_back_button = play_back;
@export_tool_button("Draw Graph") var draw_graph_button = func(): draw_graph(Evaluator.parse_equation_string(equation_string))

@export var buncha_equations: BunchaEquations
@export var clicks = 0

func play_back():
	for equation_string in buncha_equations.equations:
		draw_graph(Evaluator.parse_equation_string(equation_string))
		await get_tree().create_timer(.5).timeout

func score(value, normal, min_result, max_result):
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal) / max_score

func delete_last_graph():
	buncha_equations.equations.pop_back()
	line_2d.clear_points()

func generate_graph():
	clicks += 1
	if len(buncha_equations.equations) == 0:
		buncha_equations.equations = []
	var equation = Parentheses.generate_random(length)
	draw_graph(equation)
	equation_string = equation.to_string_ugly()
	buncha_equations.equations.append(equation_string)
	buncha_equations.equations = buncha_equations.equations

func draw_graph(equation):
	var results = Evaluator.get_all_possible_values(equation)
	var max_result = results[-1]
	var min_result = results[0]
	var normal_result = equation.evaluate("PEMDAS".split(""))
	var max_score = max(abs(max_result - normal_result), abs(min_result - normal_result))
	print("\n\nmin: %s\nmax: %s\nnormal: %s\nmax_score: %s" % [min_result, max_result, normal_result, max_score])

	line_2d.clear_points()
	for i in len(results):
		var size = Vector2(1152, 648)
		var x = remap(i, 0, len(results), 0, size.x)
		var score_value = score(results[i], normal_result, min_result, max_result)
		#var score_value = remap(results[i], min_result, max_result, 0, 1)
		var y = remap(score_value, 0, 1, size.y, 0)
		line_2d.add_point(Vector2(x, y))
	pass
