extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(Number.new(1))
	#print(Number.new(2, 2).evaluate())
	#print(Number.new(1.5))
	#print(Parentheses.new([Number.new(4), Add.new(), Number.new(2, 2)], true).evaluate_addition())
	#print(Parentheses.new([Number.new(4), Subtract.new(), Number.new(2, 2)], true).evaluate_subtraction())
	#print(Parentheses.new([Number.new(4), Multiply.new(), Number.new(2, 2)], true).evaluate_multiplication())
	#print(Parentheses.new([Number.new(4), Divide.new(), Number.new(2, 2)], true).evaluate_division())
	#print(Parentheses.new([Number.new(4), Divide.new(), Number.new(2, 2)], true).evaluate_exponents())
	
	var order = ["P", "E", "M", "D", "A", "S"]
	
	#order = ["P", "A", "S", "E", "D", "M"]
	#order = "PEADSM".split('')
	
	var equation = Parentheses.new([
		Number.new(81, 2), 
		Add.new(), 
		Number.new(14),
		Divide.new(),
		Number.new(13),
		Subtract.new(),
		Number.new(12)
	], true)
	print(equation)
	print(equation.evaluate(order))
	
	#print(get_permutations(["P", "E", "M", "D", "A", "S"]))
	var start = Time.get_ticks_usec()
	print(get_all_possible_values(equation))
	var end = Time.get_ticks_usec()
	var worker_time = (end-start)
	print(worker_time)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_all_possible_values(equation: Parentheses):
	var values = []
	for order in get_permutations(["E", "M", "D", "A", "S"]):
		var order_real = ["P"]
		order_real.append_array(order)
		values.append([order_real, equation.evaluate(order_real)])
	values.sort_custom(func(a, b): return a[1] > b[1])
	return values
	
func get_permutations(array: Array):
	var results = []
	permute(results, array, 0)
	return results
	
# https://www.geeksforgeeks.org/dsa/print-all-possible-permutations-of-an-array-vector-without-duplicates-using-backtracking/
func permute(results: Array, array: Array, idx: int):
	if (idx == len(array)):
		results.append(array.duplicate())
		return
	var i = idx
	while i < len(array):
		var temp = array[i]
		array[i] = array[idx]
		array[idx] = temp
		permute(results, array, idx + 1)
		temp = array[i]
		array[i] = array[idx]
		array[idx] = temp
		i += 1
	
class Parentheses:
	var value: Array
	var root: bool
	func _init(v: Array, isRoot: bool = false):
		value = v
		root = isRoot
	func _to_string():
		if root:
			return ''.join(value)
		return "(" + ''.join(value) + ")"
	func evaluate(order):
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
			#print(self)
		return out[0].value
					
	static func evaluate_parentheses(value, order):
		var out = []
		for i in len(value):
			var token = value[i]
			if token is Parentheses:
				out.append(token.evaluate())
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
		var out = []
		var i = 0;
		while i < len(value):
			var token = value[i]
			if token is Multiply:
				var lh = value[i - 1]
				var rh = value[i + 1]
				var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
				var sum = lh.value * rh.value
				out.remove_at(i-1)
				out.append(Number.new(sum, exponent))
				i+=1
			else:
				out.append(token)
			i+=1
		return out
	static func evaluate_division(value):
		var out = []
		var i = 0;
		while i < len(value):
			var token = value[i]
			if token is Divide:
				var lh = value[i - 1]
				var rh = value[i + 1]
				var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
				var sum = lh.value / rh.value
				out.remove_at(i-1)
				out.append(Number.new(sum, exponent))
				i+=1
			else:
				out.append(token)
			i+=1
		return out
	static func evaluate_addition(value):
		var out = []
		var i = 0;
		while i < len(value):
			var token = value[i]
			if token is Add:
				var lh = value[i - 1]
				var rh = value[i + 1]
				var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
				var sum = lh.value + rh.value
				out.remove_at(i-1)
				out.append(Number.new(sum, exponent))
				i+=1
			else:
				out.append(token)
			i+=1
		return out
	static func evaluate_subtraction(value):
		var out = []
		var i = 0;
		while i < len(value):
			var token = value[i]
			if token is Subtract:
				var lh = value[i - 1]
				var rh = value[i + 1]
				var exponent = lh.exponent * rh.exponent # TODO make this not evil !!
				var sum = lh.value - rh.value
				out.remove_at(i-1)
				out.append(Number.new(sum, exponent))
				i+=1
			else:
				out.append(token)
			i+=1
		return out
		

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
	
class Exponents extends Operator:
	func _init():
		return

class Multiply extends Operator:
	func _init():
		return
	func _to_string() -> String:
		return "×"

class Divide extends Operator:
	func _init():
		return
	func _to_string() -> String:
		return "÷"

class Add extends Operator:
	func _init():
		return
	func _to_string() -> String:
		return "+"

class Subtract extends Operator:
	func _init():
		return
	func _to_string() -> String:
		return "-"
