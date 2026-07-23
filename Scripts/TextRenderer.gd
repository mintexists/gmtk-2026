extends Control

var numberLabel = preload("res://Scenes/number_label.tscn")
var operatorLabel = preload("res://Scenes/operator.tscn")
var target:Node
var root
var equation: Parentheses = Evaluator.parse_equation_string("64 + 2^2 + 44 - ( 25 * 95 ) / 100")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root = get_tree().get_root()
	target = $HBoxContainer
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
