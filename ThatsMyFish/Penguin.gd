extends TextureButton

var isSelected = false
var playerPeng
var initialPos
var offset
var body_ref
var is_inside_dropable = false
var oldRef
var allowed = false
var possibleMoves: Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready():

	await get_tree().process_frame
	initialPos = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	isOnSlot()
	if isSelected and Global.currentGameState == Global.GAMESTATE.PLAYING:
		if Input.is_action_just_pressed("click"):
			
			offset = get_global_mouse_position() - global_position

		if Input.is_action_pressed("click"):
			
			global_position = get_global_mouse_position() - offset
		elif Input.is_action_just_released("click"):
			isSelected = false

			var tween = get_tree().create_tween()
					
			if is_inside_dropable and body_ref.hasPenguin == false:
				tween.tween_property(self,"position",body_ref.position,0.2).set_ease(Tween.EASE_OUT)
				if playerPeng == 1:
					Global.player1_points += oldRef.points
				elif playerPeng == 2:
					Global.player2_points += oldRef.points
					
				initialPos = global_position
				body_ref.hasPenguin = true
				oldRef.free()
				Global.hasMovedPenguin = true
				
				
			else:		
				tween.tween_property(self,"global_position",initialPos,0.2).set_ease(Tween.EASE_OUT)
			#print(is_inside_dropable)
	pass

func isOnSlot():
	if body_ref != null:
		if body_ref.is_in_group('droppable'):
			is_inside_dropable = true
		else:
			is_inside_dropable = false

func _on_button_down():
	if Global.currentPlayer == playerPeng:
		isSelected = true
		scale = Vector2(1.05,1.05)
	pass # Replace with function body.


func _on_button_up():
	if Global.currentPlayer == playerPeng:
		scale = Vector2(1,1)

	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	if body.is_in_group('droppable') and body.hasPenguin == false:
		body_ref = body

	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group('droppable') and body.hasPenguin == true:
		oldRef = body
	pass # Replace with function body.


func _on_pressed():
	allowed = false
	possibleMoves = Global.PenguinDirection(global_position)

	if body_ref != null:
		for i in possibleMoves:
			if i == body_ref.position:
				allowed = true
				#print("SSSS")
			#print(i, " ", round(body_ref.position))
				
	pass # Replace with function body.
