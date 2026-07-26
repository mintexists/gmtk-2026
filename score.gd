class_name ScoreContainer
extends Node2D

var absolute_score:float
var current_score:float
var target_score: float
@export var label: Label
@export_multiline var message = ""


var PEMDAS_order = "PEMDAS".split("")

func score(order:Array,equation:Parentheses) -> float:
	var normal = equation.evaluate(PEMDAS_order)
	var value = equation.evaluate(order)
	var evaluation = Evaluator.get_all_possible_values(equation)
	var min_score = evaluation[0]
	var max_score = evaluation[-1]
	var percent = get_score_percent(value,normal,min_score,max_score)
	print("normal: %s, value: %s, min: %s max: %s percent: %s" % [normal, value, min_score, max_score, percent])
	current_score += abs(value-normal)
	absolute_score += current_score
	label.text = message % [current_score,target_score, max(target_score-current_score, 0)]
	return percent
	
func max_score(equation: Parentheses) -> float:
	var normal = equation.evaluate(PEMDAS_order)
	var evaluation = Evaluator.get_all_possible_values(equation)
	var max_result = evaluation[0]
	var min_result = evaluation[-1]
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return max_score

func get_score_percent(value, normal, min_result, max_result):
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal) / max_score
	
func get_score_number(order:Array,equation:Parentheses) -> float:
	var normal = equation.evaluate(PEMDAS_order)
	var value = equation.evaluate(order)
	#var evaluation = Evaluator.get_all_possible_values(equation)
	#var max_result = evaluation[0]
	#var min_result = evaluation[-1]
	#var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal)


func reset_current_score()->void:
	current_score = 0
	label.text = message % [current_score,target_score, max(target_score-current_score, 0)]
	pass

func clear_screen():
	label.text = ""
