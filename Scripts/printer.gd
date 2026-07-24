class_name Printer
extends Node2D

@export var paper_container: Node

var paperScene = preload("res://Scenes/paper.tscn")
#var root
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#root = get_tree().get_root()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_paper(equation:Parentheses) ->void:
	var newPaper = paperScene.instantiate()
	paper_container.add_child(newPaper)
	newPaper._render(newPaper.target,equation)
	#newPaper.owner = root
	
	pass
