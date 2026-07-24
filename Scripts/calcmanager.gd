class_name Calculator
extends Control

signal pressedConfirmed

@export var isLocked:bool = false
@export var edmas_container:OrderGrabber
@export var Display:Label


func on_confirm_press()->void:
	if !isLocked:
		pressedConfirmed.emit()
