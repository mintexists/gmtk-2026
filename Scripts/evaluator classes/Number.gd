class_name Number

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
