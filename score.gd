class_name ScoreContainer
extends Node2D

var absolute_score:float
var current_score:float
@export var label: Label


var PEMDAS_order = "PEMDAS".split("")

func score(order:Array,equation:Parentheses) -> float:
	var normal = equation.evaluate(PEMDAS_order)
	var value = equation.evaluate(order)
	var evalation = Evaluator.get_all_possible_values(equation)
	var min = evalation[0]
	var max = evalation[-1]
	var percent = get_score_percent(value,normal,min,max)
	current_score += abs(value-normal)
	absolute_score += current_score
	print(current_score)
	label.text = "$%d/%d" % [current_score,0]
	return percent

func get_score_percent(value, normal, min_result, max_result):
	var max_score = max(abs(max_result - normal), abs(min_result - normal))
	return abs(value - normal) / max_score

func reset_current_score()->void:
	current_score = 0
	label.text = "$%d/%d" % [current_score,0]
	pass
