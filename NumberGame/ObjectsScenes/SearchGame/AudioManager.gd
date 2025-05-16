extends AudioStreamPlayer2D
var numSlot = preload("res://ObjectsScenes/SearchGame/NumberGenerator.tscn")
@export var audioStream: AudioStreamPlayer2D
@export var MusicTracks: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready():
	numSlot.playAudioClip.connect(_playAudioClip)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _playAudioClip(answer):
	var audioNum = answer
	
	audioStream.stream = MusicTracks[audioNum]
	audioStream.play()
