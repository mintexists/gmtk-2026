class_name Printer
extends Node2D

@export var paper_container: Node
@export var move_to_position:Vector2

var paperScene = preload("res://Scenes/paper.tscn")
#var root
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#root = get_tree().get_root()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_paper(equation:Parentheses) -> paper:
	var newPaper:paper = paperScene.instantiate()
	paper_container.add_child(newPaper)
	newPaper.get_inital_answer(equation)
	newPaper.render(0,equation)
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	#var angle = randf_range(-15.0,15)
	#tween.tween_property(newPaper,"offset_transform_rotation",angle,0.07)
	tween.tween_property(newPaper,"offset_transform_position",move_to_position,0.07)
	return newPaper
