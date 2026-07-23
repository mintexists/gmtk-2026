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
		Operator.Add.new(), 
		Number.new(14),
		Operator.Divide.new(),
		Number.new(13),
		Operator.Subtract.new(),
		Number.new(12)
	], true)
	print(equation)
	print(equation.evaluate(order))
	
	#print(get_permutations(["P", "E", "M", "D", "A", "S"]))
	#var start = Time.get_ticks_usec()
	#print(get_all_possible_values(equation))
	#var end = Time.get_ticks_usec()
	#var worker_time = (end-start)
	#print(worker_time)
	print(parse_equation_string())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func parse_equation_string():
	var string = "64 + 2^2 + 44 / ( 25 / 95 ) / 55"
	var tokens = string.split(" ")
	var current = Parentheses.new([], true)
	var i = 0;
	while i < len(tokens):
		var token = tokens[i]
		if token.is_valid_float():
			current.value.append(Number.new(token.to_float()))
		if token.contains("^"):
			
		i+=1
	
	
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
	
