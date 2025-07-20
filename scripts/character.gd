extends CharacterBody2D
class_name Character

# Set a constant tile size to fix sprites and movement to a tile structure
const tile_size = 16

# Ensure a new RayCast2D object exists for collision detection
@onready var move_ray:= RayCast2D.new()
# All Character classes will require an animated sprite
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Stores whether the character is currently moving
var moving:= false
# Used to determine whether movement should continue or stop
var wants_to_move:= false
# Determine which movement to queue up
var wants_to_move_dir: Vector2

# Dictionary to link animations to directions
var anims = {Vector2.DOWN: "walk_down",
			Vector2.LEFT: "walk_left",
			Vector2.RIGHT: "walk_right",
			Vector2.UP: "walk_up"}

# Current animation of the animated sprite
var current_anim: String
# Current direction the Character is facing
var current_dir: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Add the RayCast2D object to the tree and initialise it's direction
	add_child(move_ray)
	move_ray.target_position = Vector2.DOWN * 16
	move_ray.enabled = true
	move_ray.collision_mask = 1
	
		# On loading into the scene, ensure that the character is fixed to a tile
	position = position.snapped(Vector2.ONE * tile_size) 
	# Ensure it is aligned in the centre of a tile
	position += Vector2.ONE * tile_size/2
	
	# Ensure that the character is facing the same direction as the RayCast2D
	sprite.play("move_down")
	sprite.stop()
	sprite.frame = 0

	
func move(dir: Vector2):
	# Move the character one tile in specified direction,
	# ensuring it starts and ends within a tile
	if !move_ray.is_colliding():
		if !sprite.animation == current_anim || !sprite.is_playing():
				sprite.play(current_anim)
		# Move the character a tile in the specified direction
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir * tile_size, 0.4)
		# Set moving to true to indicate that the character is moving
		moving = true
		# Wait for the movement to be completed
		tween.finished.connect(_on_tween_finished)
	else:
		_stop_movement()

func position_snap():
	if position != position.snappedf(tile_size/2):
		position = position.snappedf(tile_size/2)

func direction_change(dir: Vector2):
	# Change the current animation to make the sprite face the new direction
	sprite.play(anims[dir])
	sprite.stop()
	sprite.frame = 0
	current_anim = anims[dir]
	# Move the RayCast2D target position to face the same direction as sprite
	move_ray.target_position = dir * tile_size
	move_ray.force_raycast_update()
	# Set the class current direction to the new direction
	current_dir = dir

func _on_tween_finished():
	position_snap()
	if wants_to_move:
		_continuous_movement()
	else:
		_stop_movement()

func _stop_movement():
	moving = false
	sprite.stop()
	sprite.frame = 0

func _continuous_movement():
	pass
