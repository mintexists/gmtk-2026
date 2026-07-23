extends VBoxContainer

func get_order()->Array:
	var order = ["P"]
	for child in get_children():
		var current = child as DraggableSwitch
		order.append(current.step)
	print(order)
	return order
