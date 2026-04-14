extends Node2D
class_name Location

signal world_change_request(to_scene_path: String)
signal interaction_request(text: Array)
signal dialogue_request(object: Non_Player_Character)
signal cutscene_request(sequence: Array, cutscene_id: String)

const PC_SCENE:= preload("res://scenes/pc.tscn")
@onready var pc: Player_Character 

@onready var spawns: Dictionary

@export var default_spawn: String

var cutscenes = {}
var cutscene_rules = []

const CH:= preload("res://scripts/Cutscene Manager/cutscene_helpers.gd")

func _ready() -> void:
	var exits := get_tree().get_nodes_in_group("Exits")
	var spawn_points := get_tree().get_nodes_in_group("Spawns")
	
	EventBus.cutscene_finished.connect(_on_cutscene_finished)
	
	# Identify all the exits in the scene, and connect to the exit request signal
	for exit in exits:
		exit.exit_requested.connect(_on_exit_requested)
	
	# Identify all of the spawns, and add to the spawn dict for the location
	for spawn in spawn_points:
		spawns[spawn.spawn_name] = spawn
	
	
	# If no target spawn provided, revert to the default spawn specified in each location
	# A failsafe for debugging
	if !Global.target_spawn:
		Global.target_spawn = default_spawn
	
	for exit in exits:
		if is_spawn_in_exit(spawns[Global.target_spawn], exit):
			exit.armed = false
	
	# Bring in the player character and add to the scene
	pc = PC_SCENE.instantiate()
	add_child(pc)
	
	# Place the PC in the target spawn position
	# Currently set to a global variable
	pc.position = spawns[Global.target_spawn].get_position()
	
	# Clear out the global target spawn to prevent possible teleportation issues
	Global.target_spawn = ""
	
	# Connect to the PC for interacting
	pc.connect("try_interact", _on_try_interact)

func initialise() -> void:
	_setup_location()
	print("resolving cutscenes")
	if resolve_cutscenes("on_enter"):
		await EventBus.cutscene_finished
	world_loaded()

func _setup_location() -> void:
	pass

func _on_exit_requested(from_scene: String, target_scene: String, target_spawn: String):
	trigger_exit(from_scene, target_spawn, target_scene)

func trigger_exit(from_scene: String, target_spawn: String, file_path: String):
	await SceneTransition.play_trans(SceneTransition.FADE_OUT)
	Global.prev_scene = from_scene
	Global.target_spawn = target_spawn
	
	world_change_request.emit(file_path)
	
func is_spawn_in_exit(spawn: Spawn, exit: ExitArea) -> bool:
	var space := get_world_2d().direct_space_state
	
	var params := PhysicsPointQueryParameters2D.new()
	params.position = spawn.global_position
	params.collide_with_areas = true
	params.collision_mask = exit.collision_mask
	
	for hit in space.intersect_point(params):
		if hit.collider == exit:
			return true
	
	return false

func _on_try_interact(target):
	if target.is_in_group("Dialogue"):
		dialogue_request.emit(target)
	if target.is_in_group("Interactable"):
		interaction_request.emit(target.text)

func resolve_cutscenes(trigger: String) -> bool:
	var cutscene_id = get_cutscene_to_play(trigger)
	if cutscene_id != "":
		play_cutscene(cutscene_id)
		print("Playing a cutscene")
		return true
	return false

func play_cutscene(cutscene_id: String):
	var sequence = cutscenes[cutscene_id]
	emit_signal("cutscene_request", sequence, cutscene_id)

func get_cutscene_to_play(trigger: String) -> String:
	for rule in cutscene_rules:
		if rule["trigger"] != trigger:
			return "" 
		
		if rule["conditions"].all(func(c): return c):
			return rule["id"]
	return ""

func _on_cutscene_finished(cutscene_id: String):
	if SceneTransition.color_rect.color.a > 0:
		SceneTransition.play_trans(SceneTransition.FADE_IN)
	Global_World_State.cutscenes.append(cutscene_id)
	

func world_loaded() -> void:
	print("World loaded, The colour rect's a value is currently " + str(SceneTransition.color_rect.color.a))
	if SceneTransition.color_rect.color.a > 0:
		SceneTransition.play_trans(SceneTransition.FADE_IN)
