extends TextureRect

#@export var fruit_texture: TextureRect

@export var grid_row: int = 0
@export var grid_col: int = 0

# Expose the fruit type to the editor
@export var fruit_type: int

var fruit_rotationList: Array = [0,90,180,270]

var disabled = false;

# Signal to notify when the fruit is selected
signal fruit_selected(fruit)
signal fruit_ready(fruit)
# Called when the node is ready
func _ready():

	await get_tree().create_timer(0.01).timeout
	fruit_ready.emit(self)
	pass

func _process(delta):
	
	pass

# Handle UI input (mouse or touch)
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and disabled == false:
		fruit_selected.emit(self)
	elif event is InputEventScreenTouch and event.pressed and disabled == false:
		fruit_selected.emit(self)

