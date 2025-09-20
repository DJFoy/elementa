extends Node

# Check that a game is loaded for loading in presets and settings
var game_loaded:= false

# Store the last scene the player was in for spawn locations/cut scenes
var prev_scene: String

# Store the direction the PC is facing between scenes
var pc_dir: Vector2

# Check whether a scene transition is occuring to prevent character input
var scene_transitioning:= false
