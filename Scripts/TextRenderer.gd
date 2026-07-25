class_name paper
extends Control

var numberLabel = preload("res://Scenes/number_label.tscn")
@export var textContainer:Node
var equation: Parentheses
var pemdasAnswer:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#equation = Evaluator.parse_equation_string(the_String)
	#_render(target,equation)
	
	pass # Replace with function body.

func get_inital_answer(equation:Parentheses):
	pemdasAnswer = equation.evaluate(["P","E","M","D","A","S"])
	

func clear() -> void:
	for rows in textContainer.get_children():
		if(rows.get_index()!=0):
			for items in rows.get_children():
				items.free()
		 

func render(target:int,equation:Parentheses) -> void:
	if !equation.root:
			var lbl = numberLabel.instantiate()
			textContainer.get_child(target).add_child(lbl)
			lbl.setup("(", "1")
	for token in equation.value:
		if token is Parentheses:
			render(target,token)
		elif token is Number:
			var lbl = numberLabel.instantiate()
			textContainer.get_child(target).add_child(lbl)
			lbl.setup(Number.tostr(token.value), Number.tostr(token.exponent))
		elif token is Operator:
			var lbl = numberLabel.instantiate()
			textContainer.get_child(target).add_child(lbl)
			lbl.setup(str(token), "1")
	if !equation.root:
			var lbl = numberLabel.instantiate()
			textContainer.get_child(target).add_child(lbl)
			lbl.setup(")", "1")
	if target == 0:
		var lbl = numberLabel.instantiate()
		textContainer.get_child(target).add_child(lbl)
		lbl.setup("= %d" % pemdasAnswer, "1")
	
	pass
