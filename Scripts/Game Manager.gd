extends Node2D
enum GameState {NEXT_PAPER, PLAY,SCORE, DAY_START, DAY_END}
var currentSTATE: GameState = GameState.DAY_START

var currentDay: int = 1

var currentPaper

@export var clock:Timer	
@export var calc: Calculator

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func spawn_paper()-> void:
	pass
