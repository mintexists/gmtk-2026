extends Node2D
enum GameState {NEXT_PAPER, PLAY,SCORE, DAY_START, DAY_END}
var currentState: GameState = GameState.DAY_START
var prevState:GameState

var currentDay: int = 0
var currentPaper: paper

@export var clockTime:int 

@export var clock: Timer	
@export var calculator: Calculator
@export var score: ScoreContainer
@export var day_panel: DayPanel
@export var printer: Printer
@export var score_overlay:Control
@export var win_overlay: WinOverlay
@export var lose_overlay: LoseOverlay

signal game_over_win
signal game_over_lose

@export
var equationSheets : Array[BunchaEquations]

var target_number_for_day = [3, 5, 6, 7, 9]
var target_equations: Array[String]

var current_equation:String 

func _ready() -> void:
	calculator.pressedConfirmed.connect(func()->void: currentState = GameState.SCORE)
	clock.timeout.connect(func()->void: currentState = GameState.DAY_END)
	calculator.draggable_moved.connect(rerender_display)
	pass

func rerender_display()-> void:
	#print("HELLLOOOO")
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
				if currentDay == 0:
					calculator.lock()
					score.clear_screen()
					await printer.print_lore()
					target_equations.clear()
					var target_score = 0
					for i in target_number_for_day[currentDay]:
						var equation = equationSheets.pick_random().equations.pick_random()
						target_score += score.max_score(Evaluator.parse_equation_string(equation))
						target_equations.append(equation)
					score.target_score = target_score
					print(target_score, " target score")
					score.reset_current_score()
					await day_panel.showDay(currentDay,score.absolute_score,target_score)
					await printer.print_rules()
					clock.start(clockTime)
					calculator.unlock()
				else:
					target_equations.clear()
					var target_score = 0
					for i in target_number_for_day[currentDay]:
						var equation = equationSheets.pick_random().equations.pick_random()
						target_score += score.max_score(Evaluator.parse_equation_string(equation))
						target_equations.append(equation)
					score.target_score = target_score
					print(target_score, " target score")
					score.reset_current_score()
					await day_panel.showDay(currentDay,score.absolute_score,target_score)
					clock.start(clockTime)
				currentState = GameState.NEXT_PAPER
		GameState.NEXT_PAPER:
			if currentState != prevState:
				prevState = currentState
				print("Executing Paper State")
				calculator.lock()
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
				calculator.unlock()
		GameState.SCORE:
			if currentState != prevState:
				prevState = currentState
				calculator.lock()
				print("Executing Score State")
				var equation = Evaluator.parse_equation_string(current_equation)
				var result = score.score(calculator.get_order(),equation)
				var max_score = score.max_score(equation)
				await score_overlay.display(determine_result_display(result), score.get_score_number(calculator.get_order(), equation),max_score)
				#await score_points()
				currentState = GameState.NEXT_PAPER
		GameState.DAY_END:
			if currentState != prevState:
				prevState = currentState
				print("Executing Day End")
				if score.current_score < score.target_score:
					lose_overlay.lose()
					game_over_lose.emit()
				elif currentDay == 5:
					win_overlay.win()
					game_over_win.emit()
				else:
					currentDay+=1
					currentState = GameState.DAY_START
	pass
	
func score_points():
	print("Score Placholder Time")
	await get_tree().create_timer(5).timeout
	print("Done")
	pass

func get_equation() -> String:
	if len(target_equations) > 0:
		return target_equations.pop_back()
	else:
		return equationSheets.pick_random().equations.pick_random()
	#var sheet = randi() % equationSheets.size()
	#var sheetSize = equationSheets[sheet].equations.size()
	#return equationSheets[sheet].equations.pick_random()
	
func determine_result_display(result:float)->String:
	print(result)
	if(result == 0.0):
		return "You did Literally Nothing!"
	elif(result <= 0.2):
		return "Horrible Job :)"
	elif(result <= 0.5):
		return "Just Ok..."
	elif(result < 1.0):
		return "Great Job!"
	elif(result == 1.0):
		return "FULL SCORE!!!!"
	return ""
