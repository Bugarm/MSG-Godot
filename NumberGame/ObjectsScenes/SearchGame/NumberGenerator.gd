extends Control

var rounds = 1
var numSlot = preload("res://ObjectsScenes/SearchGame/NumberGenerator.tscn")
var height = 6
var width = 6

@export var label: Label
@export var roundLabel: Label
@export var grid_container: GridContainer
@export var audioStream: AudioStreamPlayer2D

@export var MusicTracks: Array[AudioStream]

var numRef: Array = []

var num_grid: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	roundLabel.text = "Round:" + str(rounds)
	num_grid = GenerateSearchNum()
	#print(num_grid)
	SpawnNumSlots()
	playAudioClip()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.isSearchWin:
		rounds += 1
		
		if rounds <= 2:
			roundLabel.text = "Round:" + str(rounds)
			for count in numRef:
				if count.get_parent() == grid_container:
					grid_container.remove_child(count)
			await get_tree().process_frame
			num_grid = GenerateSearchNum()
			#print(num_grid)
			SpawnNumSlots()
			Global.isSearchWin = false
		elif rounds > 2:
			Global.isSearchWin = false
			label.text = "YOU WIN!"
			for count in numRef:
				count.numAnimation.play("flash")
			await get_tree().create_timer(0.5).timeout
			for count in numRef:
				count.numAnimation.stop()
			
			
		
	pass

func GenerateSearchNum() -> Array:
	var numList: Array = []
	var ans = randi_range(0,10)
	var ansCheck = true
	Global.searchingAns = ans
	var i = 0
	while(i < 6):
		for row in range(width):
			var row_list = []
			for col in range(height):
				var looping = true
				if ansCheck == false:
					while(looping == true):
						var num = randi_range(0,10)
						if num != ans:
							row_list.append(num)
							i += 1
							looping = false
				else:
					row_list.append(ans)
					ansCheck = false
			numList.append(row_list)
		numList.shuffle()
	
	playAudioClip()
	
	print(ans)
	return numList
	pass

func SpawnNumSlots():
	for row in range(width):
		for col in range(height):
			var numObj = numSlot.instantiate() 
			numObj.labelObj.text = str(num_grid[row][col])
			numRef.append(numObj)
			grid_container.add_child(numObj)
	pass

func playAudioClip():
	var audioNum = Global.searchingAns
	
	audioStream.stream = MusicTracks[audioNum]
	audioStream.play()

func _on_button_pressed():
	playAudioClip()
	pass # Replace with function body.
