class_name Calculator
extends Control

signal pressedConfirmed
signal draggable_moved

@export var isLocked:bool = false
@export var edmas_container:OrderGrabber
@export var Display:Label

func _ready() -> void:
	edmas_container.child_order_changed.connect(func()->void: draggable_moved.emit())

func on_confirm_press()->void:
	if !isLocked:
		pressedConfirmed.emit()

func set_display_value(value:Parentheses):
	var textToDisplay:float = value.evaluate(get_order())
	#print(textToDisplay)
	Display.text = "%d" % textToDisplay
	pass
func get_order() -> Array:
	return edmas_container.get_order()
func reset() -> void:
	edmas_container.reset_order()
