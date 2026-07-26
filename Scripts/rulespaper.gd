class_name RulesPaper
extends Control


@export var animation_player: AnimationPlayer
@export var position_offset: Vector2
@export var position_random_range = 10
@export var random_rotation_range = 10


func _ready() -> void:
	pass

func play_print_ani(time: float):
	animation_player.play("print")
	await animation_player.animation_finished
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	var speed = 0.5
	tween.tween_property(self, "offset_transform_position", position_offset + Vector2(randf_range(-position_random_range, position_random_range), randf_range(-position_random_range, position_random_range)), speed)
	tween.parallel().tween_property(self, "offset_transform_rotation", deg_to_rad(randf_range(-random_rotation_range, random_rotation_range)), speed)
	await tween.finished
	await get_tree().create_timer(time).timeout

func reset():
	offset_transform_position = Vector2(0,0)
	offset_transform_rotation = 0
	animation_player.play("RESET")
