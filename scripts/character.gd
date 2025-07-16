extends CharacterBody2D
class_name Character

const tile_size = 16
@onready var move_ray:= RayCast2D.new()
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var moving:= false
var wants_to_move:= false
var anims = {Vector2.DOWN: "walk_down",
			Vector2.LEFT: "walk_left",
			Vector2.RIGHT: "walk_right",
			Vector2.UP: "walk_up"}
var current_anim: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(move_ray)
	move_ray.target_position = Vector2.RIGHT * 16
	move_ray.enabled = true
	move_ray.collision_mask = 1
	
	
	# On loading into the scene, ensure that the character is fixed to a tile
	position = position.snapped(Vector2.ONE * tile_size) 
	# Ensure it is aligned in the centre of a tile
	position += Vector2.ONE * tile_size/2
	

	
func move(dir: Vector2):
	# Function for moving the character, ensuring it starts and ends within a tile
	# First, establish that the target tile is legal using RayCast2D
	move_ray.target_position = dir * tile_size
	move_ray.force_raycast_update()
	if !move_ray.is_colliding():
		# Add animation to the movement
		current_anim = anims[dir]
		if !sprite.animation == current_anim || !sprite.is_playing():
				sprite.play(current_anim)
		# Move the character a tile in the specified direction
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir * tile_size, 0.5)
		# Set moving to true to indicate that the character is moving
		moving = true
		# Wait for the movement to be completed
		tween.finished.connect(_on_tween_finished)
	else:
		_stop_movement()

func _on_tween_finished():
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
