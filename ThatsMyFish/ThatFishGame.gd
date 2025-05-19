extends Control

var grid_width = 8
var grid_height = 8
var tile_size = Vector2(64,64)

var tile_scene = preload("res://FishTile.tscn")
var penguin_scene = preload("res://Penguin.tscn")

@export var tile_group : Container
@export var penguin_group : Container

@export var turn_label : Label
@export var p1_label : Label
@export var p2_label : Label

var curPlayer = 1

var startingPenguin = 4
var placed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.currentPlayer = curPlayer
	p1_label.text = "Player 1 \n Score: " + str(Global.player1_points)
	p2_label.text = "Player 2 \n Score: " + str(Global.player2_points)
	
	generate_board()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.currentGameState == Global.GAMESTATE.STARTING:
		if placed >= startingPenguin:
			curPlayer += 1
			placed = 0
			if curPlayer == 3:
				Global.currentGameState = Global.GAMESTATE.PLAYING
				curPlayer = 1
				turn_label.text = "Player " + str(curPlayer) + " Turn"
		turn_label.text = "Player " + str(curPlayer) + " is placing"

	if Global.currentGameState == Global.GAMESTATE.PLAYING:
		if Global.hasMovedPenguin:
			curPlayer += 1

			if curPlayer > 2:
				curPlayer = 1
			Global.currentPlayer = curPlayer
			turn_label.text = "Player " + str(curPlayer) + " Turn"
			Global.hasMovedPenguin = false
			
			p1_label.text = "Player 1 \n Score: " + str(Global.player1_points)
			p2_label.text = "Player 2 \n Score: " + str(Global.player2_points)
	
	pass
	
var i = 0	

func generate_Fishes() -> Array[int]:
	var fishSlots: Array[int]
	var total_3Fish = 15
	var total_2Fish = 18
	var total_1Fish = 31
	
	for i in total_1Fish:
		fishSlots.append(1)
		
	for i in total_2Fish:
		fishSlots.append(2)
			
	for i in total_3Fish:
		fishSlots.append(3)
	fishSlots.shuffle()
	
	return fishSlots
	pass

func generate_board():
	
	var loop = 0
	for y in range(grid_height):
		for x in range(grid_width):

			var tile = tile_scene.instantiate()
			var fishSlots = generate_Fishes()
			tile.points = fishSlots[loop]
			tile.fishIndex = fishSlots[loop]
			
			var offsetX = 0.35
			var offsetY = 0.85
			
			var pos_x = (x + 0.7) * tile_size.x* offsetX * 3
			var pos_y = (y+ 4) * tile_size.y * offsetY
			if x % 2 == 1:
				pos_y += tile_size.y * offsetY * 0.05
				
			if y % 2 == 1:
				pos_x += tile_size.x * offsetX  * 1.5
				
			tile.position =  Vector2(pos_x, pos_y)

			tile.tilePressed.connect(SpawnPenguin)
			tile_group.add_child(tile)
			Global.tile_ref.append(tile)
			loop += 1
			#i+= 1
		#print(i)
				
func SpawnPenguin(tile):
	var penguin = penguin_scene.instantiate()
	penguin.global_position = tile.global_position
	if curPlayer == 1:
		penguin.modulate = Color.AQUAMARINE
	else:
		penguin.modulate = Color.YELLOW
		
	penguin.playerPeng = curPlayer
	penguin_group.add_child(penguin)
	placed += 1
	tile.hasPenguin = true
pass

