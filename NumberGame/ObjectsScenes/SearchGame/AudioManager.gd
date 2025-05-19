extends AudioStreamPlayer2D

signal playAudioClip(answer)
@export var node: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	playAudioClip.emit(Global.searchingAns)
	node.generatedNum.connect(playAudio)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	playAudioClip.emit(Global.searchingAns)
	pass # Replace with function body.

func playAudio():
	playAudioClip.emit(Global.searchingAns)
	pass # Replace with function body.

