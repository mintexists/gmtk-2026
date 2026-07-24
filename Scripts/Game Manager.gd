extends Node2D
enum GameState {NEXT_PAPER, PLAY,SCORE, DAY_START, DAY_END}
var currentState: GameState = GameState.DAY_START
var prevState:GameState

var currentDay: int = 1

var paperScene = preload("res://Scenes/paper.tscn")

@export var clockTime:int 

@export var clock: Timer	
@export var calculator: Calculator
@export var score: Node
@export var day_panel: DayPanel

var current_equation:Parentheses

func _ready() -> void:
	calculator.pressedConfirmed.connect(func()->void: currentState = GameState.SCORE)
	clock.timeout.connect(func()->void: currentState = GameState.DAY_END)
	pass

func _process(delta: float) -> void:
	match(currentState):
		GameState.DAY_START:
			if currentState != prevState:
				prevState = currentState
				print("Executing Day Start")
				await day_panel.showDay(currentDay)
				clock.start(clockTime)
				currentState = GameState.NEXT_PAPER
		GameState.NEXT_PAPER:
			if currentState != prevState:
				prevState = currentState
				print("Executing Paper State")
				calculator.isLocked = true
				await spawn_paper()
				print(calculator.isLocked)
				currentState = GameState.PLAY
				
		GameState.PLAY:
			if currentState != prevState:
				prevState = currentState
				print("Executing Play State")
				calculator.isLocked = false
		GameState.SCORE:
			if currentState != prevState:
				prevState = currentState
				calculator.isLocked = true
				print("Executing Score State")
				await score_points()
				currentState = GameState.NEXT_PAPER
		GameState.DAY_END:
			if currentState != prevState:
				prevState = currentState
				print("Executing Day End")
				currentDay+=1
				currentState = GameState.DAY_START
	pass

func spawn_paper()-> void:
	print("Paper Spawn Placholder Time")
	await get_tree().create_timer(5).timeout
	print("Done")
	pass
	
func score_points():
	print("Score Placholder Time")
	await get_tree().create_timer(5).timeout
	print("Done")
	pass
