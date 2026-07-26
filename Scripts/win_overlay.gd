class_name WinOverlay
extends CanvasLayer

@export var again_button: Button
@export var quit: Button

signal play_again

func _ready():
	visible = false
	again_button.pressed.connect(func(): 
		visible = false
		play_again.emit()
		)
	

func win():
	visible = true
	pass
