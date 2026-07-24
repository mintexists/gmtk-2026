extends Control

var numberLabel = preload("res://Scenes/number_label.tscn")
@export var target:Node
var root
@export_multiline()
var the_String:String
var equation: Parentheses

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_tree().get_root()
	equation = Evaluator.parse_equation_string(the_String)
	_render(target,equation)
	
	pass # Replace with function body.

func _render(target:Node,equation:Parentheses) -> void:
	if !equation.root:
			var lbl = numberLabel.instantiate()
			target.add_child(lbl)
			lbl.owner = root
			lbl.setup("(", "1")
	for token in equation.value:
		if token is Parentheses:
			_render(target,token)
		elif token is Number:
			var lbl = numberLabel.instantiate()
			target.add_child(lbl)
			lbl.owner = root
			lbl.setup(Number.tostr(token.value), Number.tostr(token.exponent))
		elif token is Operator:
			var lbl = numberLabel.instantiate()
			target.add_child(lbl)
			lbl.owner = root
			lbl.setup(str(token), "1")
	if !equation.root:
			var lbl = numberLabel.instantiate()
			target.add_child(lbl)
			lbl.owner = root
			lbl.setup(")", "1")
	pass
