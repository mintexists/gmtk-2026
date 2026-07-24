class_name DraggableSwitch
extends Panel

var isHovering:bool
var parent:Node
var current_idx: int
@export var step:String = " "

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset_transform_enabled = true
	parent = get_parent()
	current_idx = self.get_index()
	parent.child_order_changed.connect(lerp_idx)
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		isHovering = true
		pass
	if event is InputEventMouseButton and event.is_released():
		isHovering = false
		offset_transform_position.y = 0
	if event is InputEventMouseMotion and isHovering:
		var idx = self.get_index()
		offset_transform_position.y += event.relative.y
		#print(offset_transform_position.y, " ", self.size.y)
		#print(idx)
		if(offset_transform_position.y > (self.size.y)) and idx != parent.get_child_count() - 1:
			offset_transform_position.y -= self.size.y
			parent.move_child(self,idx+1)
		elif(offset_transform_position.y < -(self.size.y)) and idx != 0:
			offset_transform_position.y += self.size.y
			parent.move_child(self,idx-1)

func lerp_idx():
	if isHovering:
		return
	var prev_idx = current_idx
	current_idx = self.get_index()
	var direction = current_idx-prev_idx
	#print(direction)
	offset_transform_position.y = (size.y*-(direction))/2
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"offset_transform_position",Vector2.ZERO,0.07)
	
	pass
	
