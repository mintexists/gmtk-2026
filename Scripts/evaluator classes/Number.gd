class_name Number

var value: float
var exponent: float
static func tostr(v: float):
	return String.num(v).trim_suffix(".0")
static func tostr_truncated(v: float):
	var raw =  ("%.2f" % v)#.trim_suffix(".0").trim_suffix(".00")
	var major = raw.split(".")[0]
	var minor = raw.split(".")[1]
	return (_format_number_with_dots(v) + "." + minor).trim_suffix(".0").trim_suffix(".00")
	
	#return ("%.2f" % v).trim_suffix(".0").trim_suffix(".00")
static func _format_number_with_dots(number: int) -> String:
	var num_str: String = str(number).lstrip("-")    # this line changed
	var result: String = ""
	var count: int = 0

	for i in range(num_str.length() - 1, -1, -1):
		result = num_str[i] + result
		count += 1
		if count % 3 == 0 and i != 0:
			result = "," + result

	if number < 0:
		result = "-" + result

	return result
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
