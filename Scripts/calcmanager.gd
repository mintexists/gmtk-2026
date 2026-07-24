class_name Calculator
extends PanelContainer

var isLocked:bool
@export var edmas_container:OrderGrabber
@export var TotalLabel:Label


func on_confirm_press()->void:
	if !isLocked:
		var order = edmas_container.get_order()
		
	
