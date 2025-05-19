extends Node

var player1_points = 0
var player2_points = 0

enum GAMESTATE {STARTING, PLAYING}

var currentState_P1
var currentState_P2

var currentPlayer

var currentGameState = GAMESTATE.STARTING

var hasMovedPenguin = false

var tile_ref : Array[StaticBody2D]

var grid_width = 8
var grid_height = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func PenguinDirection(penguinPos: Vector2) -> Array[Vector2]:
	var loop = 0
	var everyPossiblePos : Array[Vector2]
	#for y in range(grid_height):
		
	for x in range(grid_width):
		var posL: Vector2
		posL.x = round(penguinPos.x + (64 * 0.35 * 3 * loop))
		posL.y = round(penguinPos.y + (64 * 0.85 * loop))
		loop += 1
		everyPossiblePos.append(posL)

		
	return everyPossiblePos
	pass
