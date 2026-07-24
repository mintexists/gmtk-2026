extends Node

func _ready() -> void:
	var order = ["P", "E", "M", "D", "A", "S"]
	#order = ["P", "A", "S", "E", "D", "M"]
	#order = "PEADSM".split('')
	
	#var equation = Parentheses.new([
		#Number.new(81, 2), 
		#Operator.Add.new(), 
		#Number.new(14),
		#Operator.Divide.new(),
		#Number.new(13),
		#Operator.Subtract.new(),
		#Number.new(12)
	#], true)
	#print(equation)
	#print(equation.evaluate(order))
	
	#print(get_permutations(["P", "E", "M", "D", "A", "S"]))

	var parsed = Evaluator.parse_equation_string("64 + 2^2 + 44 - ( 25 * 95 )^2 / 100")
	#var parsed = Evaluator.parse_equation_string("1 + 2 + 3")
	print(parsed)
	print(parsed.evaluate(order))
	print(parsed.evaluate_to_depth(order, 6))
	#var start = Time.get_ticks_usec()
	#print(Evaluator.get_all_possible_values(parsed))
	#var end = Time.get_ticks_usec()
#	var worker_time = (end-start)
	#print(worker_time)
	pass
