extends Control

var rounds = 4

@export var slot1Obj: Label
@export var slot2Obj: Label
@export var title: Label

@export var roundsLabel: Label

var zeroCheck = 0
var disableRounds = false
# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateAnswer()
	
	slot1Obj.text = str(Global.slot1)
	slot2Obj.text = str(Global.slot2)
	roundsLabel.text = "Equations Remaining: " + str(rounds)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if Global.hasAnsCorrected && disableRounds == false:
		rounds -= 1
		roundsLabel.text = "Equations Remaining: " + str(rounds)
		if rounds > 0:
			RestartGame()
		else:
			title.text = "You Win!"
			Global.hasAnsCorrected = false

	pass

func GenerateAnswer():
	Global.slot1 = randi_range(0,10)
	Global.slot2 = randi_range(0,10)
	
	Global.correct_answer = Global.slot1 + Global.slot2
	Global.answerChoices.append(Global.correct_answer)
	
	var generated = 0
	while(generated < Global.TotalObj):
		if Global.correct_answer <= 0:
			zeroCheck = randi_range(1,10)
		var wrongAnswer = randi_range(0,(Global.correct_answer + zeroCheck) - 1 )
		for wrongAns in Global.answerChoices:
			
			if wrongAnswer != wrongAns:
				Global.answerChoices.append(wrongAnswer)
				generated += 1
				break
		
	Global.answerChoices.shuffle()
	print(Global.answerChoices)
	
func RestartGame():
	Global.answerChoices= []
	Global.nextObj = 0
	GenerateAnswer()
	slot1Obj.text = str(Global.slot1)
	slot2Obj.text = str(Global.slot2)
	await get_tree().process_frame
	Global.hasAnsCorrected = false


func _on_restart_pressed():
	disableRounds = true
	rounds = 4
	roundsLabel.text = "Equations Remaining: " + str(rounds)
	RestartGame()
	await get_tree().process_frame
	Global.hasAnsCorrected = true
	await get_tree().process_frame
	Global.hasAnsCorrected = false
	disableRounds = false
	pass # Replace with function body.


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://GameScenes/MainMenu.tscn")
	pass # Replace with function body.
