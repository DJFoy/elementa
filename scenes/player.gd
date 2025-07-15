# In your character's script (e.g., character.gd)
extends CharacterBody2D

# Connect the animation player
@onready var animated_sprite = $AnimatedSprite2D

# Movement speed
var speed = 75

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Move the character
	velocity = direction * speed
	move_and_slide()

	# Update animation based on movement
	if direction.x != 0:
		if direction.x > 0:
			# Moving right
			animated_sprite.play("walk_right")
		else:
			# Moving left
			animated_sprite.play("walk_left")
	elif direction.y != 0:
		if direction.y > 0:
			# Moving down
			animated_sprite.play("walk_down")
		else:
			# Moving up
			animated_sprite.play("walk_up")
	else:
		# Not moving
		animated_sprite.pause()
		animated_sprite.frame = 0
