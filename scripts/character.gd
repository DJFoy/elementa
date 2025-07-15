extends CharacterBody2D
class_name Character

const tile_size = 16
@onready var move_ray:= RayCast2D.new()
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# On loading into the scene, ensure that the character is fixed to a tile
	position = position.snapped(Vector2.ONE * tile_size) 
	# Ensure it is aligned in the centre of a tile
	position += Vector2.ONE * tile_size/2
	
	# Add the raycast object to the scene for collision detection during movement
	add_child(move_ray)

func move(dir: Vector2):
	# Function for moving the character, ensuring it starts and ends within a tile
	# First, establish that the target tile is legal using RayCast2D
	move_ray.target_position = dir * tile_size
	move_ray.force_raycast_update()
	if !move_ray.is_colliding():
		# Add animation to the movement
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + dir * tile_size, 0.5)
		moving = true
		await tween.finished
		moving = false
		#position += dir * tile_size
