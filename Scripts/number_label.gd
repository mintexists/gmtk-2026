class_name numberLabel
extends HBoxContainer

var number
var super_script

@onready var superLabel = $SuperScript
@onready var numLabel =$Number
# Called when the node enters the scene tree for the first time.
func setup(num,sup) -> void:
	numLabel.text = num
	if sup != "1":
		superLabel.text = sup
	
