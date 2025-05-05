extends Node2D

@onready var grid_container: GridContainer = $CenterContainer/GridContainer
var fruit_scene = preload("res:///Fruit.tscn")
var rows: int = 4
var columns: int = 4
@export var fruit_textures: Array[Texture] = []

var fruit_rotationList: Array = [0,90,180,270]
var fruit_grid: Array = []  # To hold references to each fruit instance.

@onready var game_timer: Timer = $Timer
@onready var notifier: Label = $Notifier
var seconds_left: int = 60
var game_over: bool = false
var isWin = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var fruit_types: Array = []
	for fruit_type in range(6):  # 6 different types.
		for i in range(rows):   # Each type appears exactly 6 times.
			fruit_types.append(fruit_type)
	# Shuffle the list to randomize fruit placement.
	fruit_types.shuffle()
	
	# Create grid of fruits.
	var index: int = 0
	for row in range(rows):
		var row_list = []
		for col in range(columns):
			var fruit_instance = fruit_scene.instantiate()
			# Use the precomputed fruit type.
			fruit_instance.fruit_type = fruit_types[index]
			index += 1
			
			# Assign the texture based on the fruit type.
			fruit_instance.texture = fruit_textures[fruit_instance.fruit_type]
			# Store the grid coordinates on the fruit instance.
			fruit_instance.grid_row = row
			fruit_instance.grid_col = col
			# Add the fruit instance to the grid container.
			grid_container.add_child(fruit_instance)

			# Connect the fruit's selection signal.
			fruit_instance.fruit_selected.connect(_on_fruit_selected)
			fruit_instance.fruit_ready.connect(_on_fruit_ready)
			
			row_list.append(fruit_instance)
			
		fruit_grid.append(row_list)
	
	game_timer.start()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fruit_selected(fruit: TextureRect) -> void:
	if game_over:
		return
	
	var rand = randi_range(0,11)
	# Handle fruit selection.
	if(rand > 2):
		var newPos = fruit.rotation_degrees + 90
		fruit.disabled = true
	
		while(fruit.rotation_degrees < newPos):
			fruit.rotation_degrees += 5
			await get_tree().create_timer(0.01).timeout
			#print(fruit.rotation_degrees)
		
		if(fruit.rotation_degrees >= 360):
			fruit.rotation_degrees = 0	
		else:
			fruit.rotation_degrees = newPos	
		fruit.disabled = false
	else:
		fruit.modulate = "#2d2d2d"
		fruit.disabled = true
		await get_tree().create_timer(2).timeout
		fruit.disabled = false
		fruit.modulate = "ffffff"
		
	if _check_victory() == true:
			_on_game_victory()

func _check_victory() -> bool:
	# Check each column to ensure all fruits in that column have the same type.
	for col in range(columns):
		for row in range(rows):
			#print(fruit_grid[row][col].rotation)
			if fruit_grid[row][col].rotation != 0:
				return false
				
	return true		
	
	
func _on_fruit_ready(fruit: TextureRect) -> void:
	var randRot = randi_range(0,fruit_rotationList.size() - 1)
	# Handle fruit selection.
	fruit.rotation_degrees = fruit_rotationList[randRot]
	
	
func _on_timer_timeout() -> void:	
	seconds_left = seconds_left -1
	notifier.text = str(seconds_left)+"s Left"
	if(seconds_left == 0):
		game_over = true
		notifier.text = "Time's up! \n Game over."
		game_timer.stop()

func _on_game_victory() -> void:
	game_over = true
	game_timer.stop()
	notifier.text = "You Win!"

