class_name Printer
extends Node2D

@export var paper_container: Node
@export var lore: RulesPaper
@export var rules: RulesPaper

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
	await newPaper.play_print_ani()
	return newPaper
	
func print_lore():
	await lore.play_print_ani(30)
	
func print_rules():
	await rules.play_print_ani(30)
