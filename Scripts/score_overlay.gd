extends Control

#@export var messages: Dictionary[String, String] = {}
@export var rich_text_label: RichTextLabel

func _ready() -> void:
	visible = false
	#await get_tree().create_timer(15).timeout
	#await display("Good Job", 1)
	
func display(message: String):
	rich_text_label.text = message
	visible = true
	offset_transform_scale = Vector2(1, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset_transform_scale", Vector2(1, 1), 1)
	await tween.finished
	await get_tree().create_timer(1).timeout
	var close_tween = create_tween()
	close_tween.tween_property(self, "offset_transform_scale", Vector2(1, 0), .1)
	await close_tween.finished
	visible = false
