extends Label

@export var clock:Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time = clock.time_left
	text = "%02d:%02d" % [time / 60.0, fmod(time,60.0)]
	pass
