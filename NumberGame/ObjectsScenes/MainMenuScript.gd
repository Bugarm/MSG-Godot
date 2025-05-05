extends Control

@export var additionButton: Button
@export var NumSearchButton: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	additionButton.switchSceneAdd.connect(_on_switchSceneAdd)
	NumSearchButton.switchSceneSearch.connect(_on_switchSceneSearch)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
func _on_switchSceneAdd():
	get_tree().change_scene_to_file("res://GameScenes/AdditionGame.tscn")
	
	
func _on_switchSceneSearch():
	get_tree().change_scene_to_file("res://GameScenes/NumSearchGame.tscn")
	
