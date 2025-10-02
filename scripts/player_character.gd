extends Character
class_name Player_Character

@onready var player_data: PlayerCreationData

# Since this is the player character, always initialise a camera to follow
@onready var camera:= Camera2D.new()
@onready var interact_ray:= RayCast2D.new()

@onready var hair_dict:= {
	0: preload("res://resources/character_sprite_tilesets/pc_hair_1.tres"), 
	1: preload("res://resources/character_sprite_tilesets/pc_hair_2.tres")
}

var inputs:= {"move_left": Vector2.LEFT,
			"move_right": Vector2.RIGHT,
			"move_up": Vector2.UP,
			"move_down": Vector2.DOWN}

var is_locked: bool = false

func _ready() -> void:
	add_child(camera)
	super()
	add_child(interact_ray)
	interact_ray.target_position = Vector2.DOWN * 16
	interact_ray.enabled = true
	interact_ray.collide_with_areas = true
	interact_ray.collision_mask = 2
	if Global.game_loaded:
		player_data = ResourceLoader.load("res://saves/player_data.tres")
		if player_data:
			apply_character_data(player_data)
	if Global.pc_dir:
		direction_change(Global.pc_dir)
		interact_ray.target_position = Global.pc_dir * 16
	
	# Attach player locked signal
	
	Global.locked_state_changed.connect(_on_locked_state_changed)
	
	
func _process(delta: float) -> void:
	if is_locked:
		return
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
	if is_locked:
		return
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir, true):
			Global.pc_dir = inputs[dir]
			if current_dir != inputs[dir]:
				interact_ray.target_position = inputs[dir] * tile_size
				interact_ray.force_raycast_update()
				direction_change(inputs[dir])
			else:
				move(inputs[dir])
			return

func _continuous_movement() -> void:
	Global.pc_dir = wants_to_move_dir
	if current_dir != wants_to_move_dir:
		interact_ray.target_position = wants_to_move_dir * tile_size
		direction_change(wants_to_move_dir)
	move(wants_to_move_dir)

func apply_character_data(data: PlayerCreationData):
	get_node("Hair").texture = hair_dict[data.hair]
	get_node("Hair").modulate = data.hair_colour

func _on_locked_state_changed(locked: bool):
	is_locked = locked
