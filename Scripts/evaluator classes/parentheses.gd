class_name Parentheses

var value: Array
var root: bool
func _init(v: Array, isRoot: bool = false):
	value = v
	root = isRoot
func _to_string():
	if root:
		return ''.join(value)
	return "(" + ''.join(value) + ")"
func evaluate(order, debug=false):
	var out = value.duplicate_deep()
	for step in order:
		match step:
			"P":
				out = evaluate_parentheses(out, order)
			"E":
				out = evaluate_exponents(out)
			"M":
				out = evaluate_multiplication(out)
			"D":
				out = evaluate_division(out)
			"A":
				out = evaluate_addition(out)
			"S":
				out = evaluate_subtraction(out)
		if debug:
			print(out)
	return out[0].value
static func evaluate_parentheses(value, order):
	var out = []
	for i in len(value):
		var token = value[i]
		if token is Parentheses:
			out.append(Number.new(token.evaluate(order)))
		else: 
			out.append(token)
	return out
static func evaluate_exponents(value):
	var out = []
	for i in len(value):
		var token = value[i]
		if token is Number:
			var result = token.evaluate()
			out.append(Number.new(result))
		else:
			out.append(token)
	return out
static func evaluate_multiplication(value):
	var i = 0;
	while i < len(value):
		var token = value[i]
		if token is Operator.Multiply:
			var lh = value[i - 1]
			var rh = value[i + 1]
			var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
			var sum = lh.value * rh.value
			value[i] = Number.new(sum, exponent)
			value.remove_at(i + 1)
			value.remove_at(i - 1)
			i -= 1
		i+=1
	return value
static func evaluate_division(value):
	var i = 0;
	while i < len(value):
		var token = value[i]
		if token is Operator.Divide:
			var lh = value[i - 1]
			var rh = value[i + 1]
			var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
			var sum = lh.value / rh.value
			value[i] = Number.new(sum, exponent)
			value.remove_at(i + 1)
			value.remove_at(i - 1)
			i -= 1
		i+=1
	return value

static func evaluate_addition(value: Array):
	var i = 0;
	while i < len(value):
		var token = value[i]
		if token is Operator.Add:
			var lh = value[i - 1]
			var rh = value[i + 1]
			var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
			var sum = lh.value + rh.value
			value[i] = Number.new(sum, exponent)
			value.remove_at(i + 1)
			value.remove_at(i - 1)
			i -= 1
		i+=1
	return value
static func evaluate_subtraction(value):
	var i = 0;
	while i < len(value):
		var token = value[i]
		if token is Operator.Subtract:
			var lh = value[i - 1]
			var rh = value[i + 1]
			var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
			var sum = lh.value - rh.value
			value[i] = Number.new(sum, exponent)
			value.remove_at(i + 1)
			value.remove_at(i - 1)
			i -= 1
		i+=1
	return value
	
