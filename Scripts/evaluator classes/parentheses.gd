class_name Parentheses

var value: Array
var root: bool
var exponent: float
var ugly: bool
func _init(v: Array, isRoot: bool = false, exp: float = 1, isUgly = false):
	value = v
	root = isRoot
	exponent = exp
	ugly = isUgly
func _to_string():
	if ugly:
		return to_string_ugly()
	if root:
		return ''.join(value)
	if exponent == 1.0:
		return "(" + ''.join(value) + ")"
	else:
		return "(" + ''.join(value) + ")^" + Number.tostr(exponent)
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
func evaluate_to_depth(order, depth, debug=false):
	var temp = value.duplicate()
	var out = []
	for i in range(depth):
	#for step in order:
		var step = order[i]
		match step:
			"P":
				temp = evaluate_parentheses(temp, order)
			"E":
				temp = evaluate_exponents(temp)
			"M":
				temp = evaluate_multiplication(temp)
			"D":
				temp = evaluate_division(temp)
			"A":
				temp = evaluate_addition(temp)
			"S":
				temp = evaluate_subtraction(temp)
		if debug:
			print(temp)
		out.append(temp.duplicate())
	return out.map(func (v): return Parentheses.new(v, true))
static func evaluate_parentheses(value, order):
	var out = []
	for i in len(value):
		var token = value[i]
		if token is Parentheses:
			out.append(Number.new(token.evaluate(order), token.exponent))
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

static func generate_random(length):
	var root = Parentheses.new([], true)
	var current = root
	var prev = root
	var number_range = Vector2(-10, 99)
	var exponent_chance = 0.1;
	var parentheses_chance = .1
	var parentheses_length_options = [1, 1, 2]
	var parentheses_counter = 0
	var parentheses_max = 0
	var operators = [Operator.Add, Operator.Subtract, Operator.Multiply, Operator.Divide]
	for i in length - 1:
		if current == root and randf() < parentheses_chance:
			prev = current
			current = Parentheses.new([], false, 1, true)
			prev.value.append(current)
			parentheses_counter = 0
			parentheses_max = parentheses_length_options.pick_random()
		var number_to_add = Number.new(randi_range(number_range.x, number_range.y))
		if randf() < exponent_chance:
			number_to_add.exponent = randi_range(2, 3)
		current.value.append(number_to_add)
		current.value.append(operators.pick_random().new())
		if current != root and (parentheses_counter >= parentheses_max or i == length - 2):
			number_to_add = Number.new(randi_range(number_range.x, number_range.y))
			if randf() < exponent_chance:
				number_to_add.exponent = randi_range(2, 3)
			current.value.append(number_to_add)
			current = prev
			current.value.append(operators.pick_random().new())
		parentheses_counter += 1
		pass
	if root != current:
		current = root
	var number_to_add = Number.new(randi_range(number_range.x, number_range.y))
	if randf() < exponent_chance:
		number_to_add.exponent = randi_range(2, 3)
	root.value.append(number_to_add)
	return root
	
func to_string_ugly():
	var out = ""
	if root:
		out = ' '.join(value)
	elif exponent == 1.0:
		out = "( " + ' '.join(value) + " )"
	else:
		out = "( " + ' '.join(value) + " )^" + Number.tostr(exponent)
	out = out.replace("×", "*")
	out = out.replace("÷", "/")
	return out
