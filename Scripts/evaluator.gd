extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(Number.new(1))
	print(Number.new(2, 2).evaluate())
	print(Number.new(1.5))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

class Number:
	var value: float
	var exponent: float
	static func tostr(v: float):
		return String.num(v).trim_suffix(".0")
	func _init(v: float, e: float = 1):
		value = v
		exponent = e
	func _to_string() -> String:
		if exponent == 1.0:
			return "%s" % tostr(value)
		else:
			return "%s^%s" % [tostr(value), tostr(exponent)]
	func evaluate():
		return pow(value, exponent)

@abstract class Operator:
	@abstract func _init()
