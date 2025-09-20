extends Node2D
class_name Location

@onready var prev_scene: String
const PC = preload("res://scripts/player_character.gd")

@onready var pc_load:= preload("res://scenes/pc.tscn")
@onready var pc: Player_Character
# @onready var player_data: PlayerCreationData

@onready var scene_trans_load:= preload("res://scenes/scene_transition.tscn")
@onready var scene_trans: Node2D

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
	
	pc = pc_load.instantiate()
	add_child(pc)
	pc.position = spawns[prev_scene].get_position()
	# Spawn in the transition node
	scene_trans = scene_trans_load.instantiate()
	add_child(scene_trans)
	scene_trans.get_node("AnimationPlayer").play("fade_in")
	await get_tree().create_timer(0.3).timeout
	get_node("/root/Global").scene_transitioning = false

func leave_trans_area() -> void:
	for area in get_tree().get_nodes_in_group("Exits"):
		area.monitoring = true

func trigger_exit(cur_scene: String, file_path: String):
	get_node("/root/Global").scene_transitioning = true
	await get_tree().create_timer(0.5).timeout
	scene_trans.get_node("AnimationPlayer").play("fade_out")
	await get_tree().create_timer(0.3).timeout
	get_node("/root/Global").prev_scene = cur_scene
	get_tree().change_scene_to_file(file_path)
