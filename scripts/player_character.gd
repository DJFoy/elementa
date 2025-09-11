extends Character
class_name Player_Character

# Since this is the player character, always initialise a camera to follow
@onready var camera:= Camera2D.new()

@onready var character_data: PlayerCreationData

@onready var hair_dict:= {
	0: preload("res://resources/character_sprite_tilesets/pc_hair_1.tres"), 
	1: preload("res://resources/character_sprite_tilesets/pc_hair_2.tres")
}

var inputs:= {"move_left": Vector2.LEFT,
			"move_right": Vector2.RIGHT,
			"move_up": Vector2.UP,
			"move_down": Vector2.DOWN}

func _ready() -> void:
	add_child(camera)
	if character_data:
		apply_character_data(character_data)
	super()
	
func _process(delta: float) -> void:
	wants_to_move = ["move_up", "move_down", "move_left", "move_right"].any(
		func(action): return Input.is_action_pressed(action, true)
		)
	if wants_to_move:
		for dir in inputs.keys():
			if Input.is_action_pressed(dir):
				wants_to_move_dir = inputs[dir]
	else:
		wants_to_move_dir = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir, true):
			if current_dir != inputs[dir]:
				direction_change(inputs[dir])
			else:
				move(inputs[dir])
			return

func _continuous_movement() -> void:
	if current_dir != wants_to_move_dir:
		direction_change(wants_to_move_dir)
	move(wants_to_move_dir)

func apply_character_data(data: PlayerCreationData):
	get_node("Hair").texture = hair_dict[data.hair]
	get_node("Hair").modulate = data.hair_colour
