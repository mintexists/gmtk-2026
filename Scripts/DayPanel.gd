class_name DayPanel
extends CanvasLayer

@export_multiline var message = ""
@export var label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showDay(dayCount:int,total:float,target:float) -> void:
	visible = true
	
	print("it is day:" , dayCount)
	label.text = message % [5 - dayCount, total, target]
	label.visible_ratio = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, 8)
	await tween.finished
	await get_tree().create_timer(3).timeout
	visible = false
	pass
