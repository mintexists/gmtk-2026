extends Control

#@export var messages: Dictionary[String, String] = {}
@export var rich_text_label: RichTextLabel
@export var label: Label

func _ready() -> void:
	visible = false
	#await get_tree().create_timer(15).timeout
	#await display("Good Job", 1)
	
func display(message: String, current:float,max_score: float):
	rich_text_label.text = message
	label.text = "You have commited $%s/$%s in tax fraud" % [Number.tostr_truncated(current),Number.tostr_truncated(max_score)]
	visible = true
	offset_transform_scale = Vector2(1, 0)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "offset_transform_scale", Vector2(1, 1), 1)
	await tween.finished
	await get_tree().create_timer(3).timeout
	var close_tween = create_tween()
	close_tween.tween_property(self, "offset_transform_scale", Vector2(1, 0), .1)
	await close_tween.finished
	visible = false
