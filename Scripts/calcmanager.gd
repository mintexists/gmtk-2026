class_name Calculator
extends Control

signal pressedConfirmed

@export var isLocked:bool = false
@export var edmas_container:OrderGrabber
@export var Display:Label


func on_confirm_press()->void:
	if !isLocked:
		pressedConfirmed.emit()

func set_display_value(value:Parentheses):
	var textToDisplay:float = value.evaluate(get_order())
	print(textToDisplay)
	Display.text = "%010d" % textToDisplay
	pass
func get_order() -> Array:
	return edmas_container.get_order()
func reset() -> void:
	edmas_container.reset_order()
