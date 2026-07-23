@abstract class_name Operator

#@abstract class Operator:
	#@abstract func _init()
	
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
