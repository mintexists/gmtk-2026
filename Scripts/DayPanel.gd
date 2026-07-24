class_name DayPanel
extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showDay(dayCount:int) -> void:
	visible = true
	print("it is day:" , dayCount)
	await get_tree().create_timer(5).timeout
	visible = false
	pass
