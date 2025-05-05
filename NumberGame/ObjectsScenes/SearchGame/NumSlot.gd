extends TextureRect

@export var labelObj: Label
@export var numAnimation: AnimationPlayer

var interacted = false
var checkLose = false
var flashdelay = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Global.checkLose && flashdelay == false:
		CheckLose()

	elif interacted:
		if Input.is_action_just_pressed("click"):
			if str(Global.searchingAns) == labelObj.text:
				print("you winnn")
				Global.isSearchWin = true
			else:
				Global.checkLose = true
	pass

func CheckLose():
	if str(Global.searchingAns) == labelObj.text:
		numAnimation.play("flash")
		flashdelay = true
		await get_tree().create_timer(1).timeout
		numAnimation.play("reset")
		Global.checkLose = false
		flashdelay = false
		

func _on_mouse_entered():
	interacted = true
	pass # Replace with function body.


func _on_mouse_exited():
	interacted = false
	pass # Replace with function body.
