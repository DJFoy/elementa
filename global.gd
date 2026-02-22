extends Node

# This global is for storing game states

# Check that a game is loaded for loading in presets and settings
var game_loaded:= false

# Store the last scene the player was in for cut scenes
var prev_scene: String

# Store the target destination for spawning
var target_spawn: String

# Store the direction the PC is facing between scenes
var pc_dir: Vector2

# Check whether a scene transition is occuring to prevent character input
var scene_transitioning:= false

# Generate a state for interacting - character cannot move until interaction
# ends
var interacting:= false

# Create a player lock function interaction

var lock_count: int = 0

signal locked_state_changed(is_locked: bool)

func lock():
	lock_count += 1
	if lock_count == 1:
		locked_state_changed.emit(true)

func unlock():
	lock_count = max(0, lock_count - 1)
	if lock_count == 0:
		locked_state_changed.emit(false)

func is_locked() -> bool:
	return lock_count > 0
