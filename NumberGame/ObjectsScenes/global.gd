extends Node2D

var is_dragging = false
var inDragObj = false
var correct_answer: int
var slot1: int
var slot2: int

var TotalObj = 2

var nextObj = 0
var answerChoices: Array = []

var hasAnsCorrected = false
var showAnswer = false

#//
var searchingAns = 0
var checkLose = false
var isSearchWin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	is_dragging = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func CheckAnswer(answer: int) -> bool:
	if correct_answer == answer:
		return true
	else:
		return false

	

