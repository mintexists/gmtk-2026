extends Node2D
enum GameState {NEXT_PAPER, PLAY,SCORE, DAY_START, DAY_END}
var currentState: GameState = GameState.DAY_START
var prevState:GameState

var currentDay: int = 1

var paperScene = preload("res://Scenes/paper.tscn")


@export var clock: Timer	
@export var calculator: Calculator
@export var score: Node
@export var day_panel: DayPanel

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match(currentState):
		GameState.DAY_START:
			if currentState != prevState:
				prevState = currentState
				await day_panel.showDay(currentDay)
				clock.start()
				currentState = GameState.NEXT_PAPER
			pass
		GameState.NEXT_PAPER:
			if currentState != prevState:
				#lock player control
				print("Executing Paper Spawn")
				calculator.isLocked = true
				print(calculator.isLocked)
				await spawn_paper()
				currentState = GameState.PLAY
		GameState.PLAY:
			if currentState != prevState:
				print("Executing PlayMode")
				calculator.isLocked = false
				prevState = currentState
			pass
		GameState.SCORE:
			pass
		GameState.DAY_END:
			pass
	pass

func spawn_paper()-> void:
	print("Paper Spawn Placholder Time")
	await get_tree().create_timer(5).timeout
	print("Done")
	pass
