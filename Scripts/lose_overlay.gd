class_name LoseOverlay
extends CanvasLayer

signal play_again
@export var again_button: Button
@export var quit: Button

func _ready():
	visible = false

	visible = false
	again_button.pressed.connect(func(): 
		visible = false
		play_again.emit()
		)
	quit.pressed.connect(func(): get_tree().quit())
	


func lose():
	visible = true
	pass
