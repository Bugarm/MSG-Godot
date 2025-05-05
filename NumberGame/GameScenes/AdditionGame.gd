extends Control

var rounds = 1

@export var slot1Obj: Label
@export var slot2Obj: Label
@export var title: Label
var zeroCheck = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GenerateAnswer()
	
	slot1Obj.text = str(Global.slot1)
	slot2Obj.text = str(Global.slot2)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rounds < 4:
		if Global.hasAnsCorrected:
			RestartGame()
			rounds += 1
	else:
		title.text = "You Win!"
	pass

func GenerateAnswer():
	Global.slot1 = randi_range(0,10)
	Global.slot2 = randi_range(0,10)
	
	Global.correct_answer = Global.slot1 + Global.slot2
	Global.answerChoices.append(Global.correct_answer)
	
	var generated = 0
	while(generated < Global.TotalObj):
		if Global.correct_answer <= 0:
			zeroCheck = randi_range(0,10)
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
