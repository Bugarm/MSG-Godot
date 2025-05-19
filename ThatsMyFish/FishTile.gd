extends StaticBody2D

@export var fishTexture: Array[Texture]
@export var textureFish: TextureButton

signal tilePressed(tile)

var fishIndex = 0
var hasPenguin = false
var points = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	textureFish.texture_normal = fishTexture[fishIndex - 1]

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	pass # Replace with function body.


func _on_fish_tile_pressed():
	if not hasPenguin and Global.currentGameState == Global.GAMESTATE.STARTING:
		tilePressed.emit(self)
	pass # Replace with function body.
