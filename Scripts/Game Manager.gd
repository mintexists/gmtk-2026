extends Node2D
enum GameState {NEXT_PAPER, PLAY,SCORE, DAY_START, DAY_END}
var currentState: GameState = GameState.DAY_START
var prevState:GameState

var currentDay: int = 1
var currentPaper: paper

@export var clockTime:int 

@export var clock: Timer	
@export var calculator: Calculator
@export var score: Node
@export var day_panel: DayPanel
@export var printer: Printer

@export
var equationSheets : Array[BunchaEquations]

var current_equation:String 

func _ready() -> void:
	calculator.pressedConfirmed.connect(func()->void: currentState = GameState.SCORE)
	clock.timeout.connect(func()->void: currentState = GameState.DAY_END)
	calculator.draggable_moved.connect(rerender_display)
	pass

func rerender_display()-> void:
	print("HELLLOOOO")
	if currentPaper != null:
		var real_equation = Evaluator.parse_equation_string(current_equation)
		calculator.set_display_value(real_equation)
		var depth = real_equation.evaluate_to_depth(calculator.get_order(),6)
		currentPaper.clear()
		for i in len(depth): 
			currentPaper.render(i+1,depth[i])

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
				current_equation = get_equation()
				print("current equation",current_equation)
				var token_equation = Evaluator.parse_equation_string(current_equation)
				var newPaper = await printer.spawn_paper(token_equation)
				currentPaper = newPaper
				calculator.reset()
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

func get_equation() -> String:
	var sheet = randi() % equationSheets.size()
	var sheetSize = equationSheets[sheet].equations.size()
	return equationSheets[sheet].equations.pick_random()
