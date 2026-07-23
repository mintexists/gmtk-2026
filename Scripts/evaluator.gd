class_name Evaluator
	
static func parse_equation_string(string: String):
	var tokens = string.split(" ")
	var current = Parentheses.new([], true)
	var prev = null
	var i = 0;
	while i < len(tokens):
		var token = tokens[i]
		if token.is_valid_float():
			current.value.append(Number.new(token.to_float()))
		if token.contains("^"):
			var token_split = token.split("^")
			if token_split[0].is_valid_float() and token_split[1].is_valid_float():
				current.value.append(Number.new(token_split[0].to_float(), token_split[1].to_float()))
		if token == "+":
			current.value.append(Operator.Add.new())
		if token == "-":
			current.value.append(Operator.Subtract.new())
		if token == "/":
			current.value.append(Operator.Divide.new())
		if token == "*":
			current.value.append(Operator.Multiply.new())
		if token == "(":
			prev = current
			var new = Parentheses.new([])
			current.value.append(new)
			current = new
		if token == ")":
			current = prev
		i+=1
	return current
	
	
static func get_all_possible_values(equation: Parentheses):
	var values = []
	for order in _get_permutations(["E", "M", "D", "A", "S"]):
		var order_real = ["P"]
		order_real.append_array(order)
		#values.append([order_real, equation.evaluate(order_real)])
		values.append(equation.evaluate(order_real))
	#values.sort_custom(func(a, b): return a[1] > b[1])
	values.sort()
	return values
	
static func _get_permutations(array: Array):
	var results = []
	permute(results, array, 0)
	return results
	
# https://www.geeksforgeeks.org/dsa/print-all-possible-permutations-of-an-array-vector-without-duplicates-using-backtracking/
static func permute(results: Array, array: Array, idx: int):
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
	
