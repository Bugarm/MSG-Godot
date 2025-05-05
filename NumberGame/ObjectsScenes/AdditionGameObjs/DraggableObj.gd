extends Control

var answer: int

var draggable = false
var is_inside_dropable = false
var body_ref
var offset: Vector2
var initialPos: Vector2
var curAns: int
var checkAnswer: bool

@export var answerText: Label

# Called when the node enters the scene tree for the first time.
func _ready():
	initialPos = global_position
	await get_tree().process_frame
	print(Global.nextObj, " ", Global.answerChoices[Global.nextObj])
	curAns = Global.answerChoices[Global.nextObj]
	answerText.text = str(Global.answerChoices[Global.nextObj])
	Global.nextObj += 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(Global.inDragObj)
	
	if Global.hasAnsCorrected:
		RestartObj()

	else:
		isOnSlot()
		if draggable:
			if Input.is_action_just_pressed("click"):
				offset = get_global_mouse_position() - global_position
				Global.is_dragging = true
			if Input.is_action_pressed("click"):
				global_position = get_global_mouse_position() - offset
			elif Input.is_action_just_released("click"):
				Global.is_dragging = false	
				draggable = false
				scale = Vector2(0.8,0.8)
					
				TweenAnswerSlot()

func _on_area_2d_body_entered(body):
	if body.is_in_group('dropable'):
		body_ref = body

func _on_sprite_2d_mouse_entered():
	#print("in")
	if Global.is_dragging == false:
		draggable = true
		scale = Vector2(0.85,0.85)
	pass # Replace with function body.



func _on_sprite_2d_mouse_exited():
	#print("out")
	if Global.is_dragging == false:
		draggable = false
		scale = Vector2(0.8,0.8)
	pass # Replace with function body.

func isOnSlot():
	if body_ref != null:
		if body_ref.is_in_group('dropable'):
			is_inside_dropable = true
		else:
			is_inside_dropable = false

func checkAnsSlot() -> bool:
	if Global.CheckAnswer(curAns):
		return true
	else:
		return false

func TweenAnswerSlot():
	var tween = get_tree().create_tween()

	if is_inside_dropable:
		if(checkAnsSlot()):
			tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			self.modulate = "#008000"
			print("WIn")
			Global.hasAnsCorrected = true
			
		else:
			tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
			self.modulate = "#FF0000"

func RestartObj():
	
	if Global.nextObj < 3:
		curAns = Global.answerChoices[Global.nextObj]
		answerText.text = str(Global.answerChoices[Global.nextObj])
		Global.nextObj += 1
	self.modulate = "#FFFFFF"
	await get_tree().create_timer(0.2).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
	
	
