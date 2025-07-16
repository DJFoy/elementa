extends Character
class_name Player_Character

@onready var camera:= Camera2D.new()
@onready var character:= Character.new()

var inputs:= {"move_left": Vector2.LEFT,
			"move_right": Vector2.RIGHT,
			"move_up": Vector2.UP,
			"move_down": Vector2.DOWN}

func _ready() -> void:
	add_child(camera)
	
func _process(delta: float) -> void:
	wants_to_move = ["move_up", "move_down", "move_left", "move_right"].any(
		func(action): return Input.is_action_pressed(action, true)
		)

func _unhandled_input(event: InputEvent) -> void:
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(inputs[dir])

func _continuous_movement():
	for dir in inputs.keys():
		if Input.is_action_pressed(dir, true):
			move(inputs[dir])
