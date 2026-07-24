class_name OrderGrabber
extends VBoxContainer

func get_order()->Array:
	var order = ["P"]
	for child in get_children():
		var current = child as DraggableSwitch
		order.append(current.step)
	print(order)
	return order

func reset_order()->void:
	for row in get_children():
		var r = row as DraggableSwitch
		match r.step:
			"E":
				move_child(r,0)
				r.lerp_idx()
				pass
			"M":
				move_child(r,1)
				r.lerp_idx()
				pass
			"D":
				move_child(r,2)
				r.lerp_idx()
				pass
			"A": 
				move_child(r,3)
				r.lerp_idx()
				pass
			"S":
				move_child(r,4)
				r.lerp_idx()
				pass
