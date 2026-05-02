extends Character
class_name Player_Character

signal try_interact(interactable)
signal pc_about_to_move(cur_position: Vector2, dir: Vector2i)

@onready var player_data: PlayerCreationData

# Since this is the player character, always initialise a camera to follow
@onready var camera:= Camera2D.new()
@onready var interact_ray:= RayCast2D.new()

@onready var skin: Sprite2D = $SkinTone
@onready var clothes: Sprite2D = $Clothes
@onready var hair: Sprite2D = $Hair
@onready var hair_shadows: Sprite2D = $HairShadows
@onready var eyes: Sprite2D = $Eyes

@export var hair_choice: int = 1
@export var hair_colour_choice: Color = Color.WHITE
@export var eye_colour_choice: Color = Color.WHITE
@export var skin_colour_choice: int = 1
@export var clothes_choice: int = 1

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
	Global_World_State.last_location = global_position
	if GameState.game_loaded:
		player_data = ResourceLoader.load("res://saves/player_data.tres")
		if player_data:
			apply_character_data(player_data)
	load_textures()
	if GameState.pc_dir:
		direction_change(GameState.pc_dir)
		interact_ray.target_position = GameState.pc_dir * 16
	
	# Attach player locked signal
	
	GameState.locked_state_changed.connect(_on_locked_state_changed)

func _unhandled_input(event: InputEvent) -> void:
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
	if GameState.interacting:
		return
	if moving:
		return
	if Input.is_action_just_pressed("interact"):
		if interact_ray.is_colliding():
			try_interact.emit(interact_ray.get_collider())
			return
	for dir in inputs.keys():
		if event.is_action_pressed(dir, true):
			GameState.pc_dir = inputs[dir]
			if current_dir != inputs[dir]:
				interact_ray.target_position = inputs[dir] * tile_size
				interact_ray.force_raycast_update()
				direction_change(inputs[dir])
			else:
				move(inputs[dir])
				pc_about_to_move.emit(global_position, inputs[dir])
				Global_World_State.last_location = global_position
			return

func _continuous_movement() -> void:
	if is_locked:
		_stop_movement()
		return
	GameState.pc_dir = wants_to_move_dir
	if current_dir != wants_to_move_dir:
		interact_ray.target_position = wants_to_move_dir * tile_size
		direction_change(wants_to_move_dir)
	move(wants_to_move_dir)
	pc_about_to_move.emit(global_position, wants_to_move_dir)
	Global_World_State.last_location = global_position

func get_sprite_asset(category: String, filename: String) -> String:
	return "res://assets/character_assets/pc_assets/overworld_sprite/%s/%s.png" % [category, filename]

func apply_character_data(data: PlayerCreationData):
	hair_choice = data.hair
	hair_colour_choice = data.hair_colour
	eye_colour_choice = data.eye_colour
	skin_colour_choice = data.skin_colour
	clothes_choice = data.clothes

func load_textures():
	skin.texture = load(get_sprite_asset("skin", "tone_%d" % skin_colour_choice))
	clothes.texture = load(get_sprite_asset("clothes", "outfit_%d" % clothes_choice))
	hair_shadows.texture = load(get_sprite_asset("shadows", "h%d_st%d_shadow" % [hair_choice, skin_colour_choice]))
	eyes.modulate = eye_colour_choice
	hair.texture = load(get_sprite_asset("hair", "h%d" % hair_choice))
	hair.modulate = hair_colour_choice

func _on_locked_state_changed(locked: bool):
	is_locked = locked
