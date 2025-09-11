extends Node2D
class_name Location

@onready var prev_scene: String

@onready var pc_load:= preload("res://scenes/pc.tscn")
@onready var pc: Player_Character
@onready var player_data: PlayerCreationData

@onready var spawns: Dictionary


func _ready() -> void:
	# Turn off monitoring for Area2D when initialising location to prevent infinite loop
	for area in get_tree().get_nodes_in_group("Exits"):
		area.monitoring = false
	# Adding in a fail safe for testing - if you spawn into this scene
	# and there was no previous scene, default spawn location
	if !get_node("/root/Global").prev_scene:
		prev_scene = "PlayerInit"
	else:
		prev_scene = get_node("/root/Global").prev_scene
	
	
	player_data = ResourceLoader.load("res://saves/player_data.tres")
	pc = pc_load.instantiate()
	pc.character_data = player_data
	add_child(pc)
	pc.position = spawns[prev_scene].get_position()

func leave_trans_area() -> void:
	for area in get_tree().get_nodes_in_group("Exits"):
		area.monitoring = true
