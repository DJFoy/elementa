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
var locked_doors = []

const CH:= preload("res://scripts/Cutscene Manager/cutscene_helpers.gd")

@onready var tile_maps: Node2D = $TileMaps

@export var tilemaps: Array[TileMapLayer]

var navigation: Navigation
var actors_map = {}

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
	if !GameState.target_spawn:
		GameState.target_spawn = default_spawn
	
	for exit in exits:
		if is_spawn_in_exit(spawns[GameState.target_spawn], exit):
			exit.armed = false
	
	# Bring in the player character and add to the scene
	pc = PC_SCENE.instantiate()
	pc.actor_id = "Player_Character"
	add_child(pc)
	
	# Place the PC in the target spawn position
	# Currently set to a global variable
	pc.position = spawns[GameState.target_spawn].get_position()
	
	# Clear out the global target spawn to prevent possible teleportation issues
	GameState.target_spawn = ""
	
	# Connect to the PC for interacting
	pc.connect("try_interact", _on_try_interact)
	pc.connect("pc_about_to_move", _on_pc_move)
	
	navigation = Navigation.new()
	navigation.tilemaps = tilemaps
	navigation.build()
	
	initialise_actor_map()

func initialise() -> void:
	_setup_location()
	if resolve_cutscenes("on_enter"):
		await EventBus.cutscene_finished
	lock_doors()
	world_loaded()

func _setup_location() -> void:
	pass

func _on_exit_requested(from_scene: String, target_scene: String, target_spawn: String):
	trigger_exit(from_scene, target_spawn, target_scene)

func trigger_exit(from_scene: String, target_spawn: String, file_path: String):
	await SceneTransition.play_trans(SceneTransition.FADE_OUT)
	GameState.prev_scene = from_scene
	GameState.target_spawn = target_spawn
	
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

func _on_try_interact(target: Node2D):
	if "npc_resource" in target:
		npc_look_on_interact(target)
		var npc_id = target.npc_resource.npc_name
		if resolve_cutscenes("on_interact", npc_id):
			await EventBus.cutscene_finished
			return
	if target.is_in_group("Dialogue"):
		dialogue_request.emit(target)
	if target.is_in_group("Interactable"):
		interaction_request.emit(target.text)

func resolve_cutscenes(trigger: String, target: String = "") -> bool:
	var cutscene_id = get_cutscene_to_play(trigger, target)
	if cutscene_id != "":
		play_cutscene(cutscene_id)
		print("Playing a cutscene")
		return true
	return false

func play_cutscene(cutscene_id: String):
	var sequence = cutscenes[cutscene_id]
	emit_signal("cutscene_request", sequence, cutscene_id)

func get_cutscene_to_play(trigger: String, target: String) -> String:
	for rule in cutscene_rules:
		if rule["trigger"] != trigger && rule["target"] != target:
			continue
		if rule["conditions"].all(func(c): return c.call()):
			return rule["id"]
	return ""

func _on_cutscene_finished(cutscene_id: String):
	if SceneTransition.color_rect.color.a > 0:
		SceneTransition.play_trans(SceneTransition.FADE_IN)
	Global_World_State.cutscenes.append(cutscene_id)
	lock_doors()
	

func world_loaded() -> void:
	if SceneTransition.color_rect.color.a > 0:
		SceneTransition.play_trans(SceneTransition.FADE_IN)

func npc_look_on_interact(target: Non_Player_Character) -> void:
	var dir_to_turn = target.global_position.direction_to(pc.global_position)
	
	target.direction_change(dir_to_turn)

func initialise_actor_map():
	actors_map.clear()
	
	var actors = get_tree().get_nodes_in_group("actors")
	
	for actor in actors:
		if not is_ancestor_of(actor):
			continue
		
		var cell = tilemaps[0].local_to_map(tilemaps[0].to_local(actor.global_position))
		actors_map[actor] = cell

func update_actor_map(actor: Character):
	var cell = tilemaps[0].local_to_map(tilemaps[0].to_local(actor.global_position))
	actors_map[actor] = cell

func path_move_requested(actor: Character, start_position: Vector2, destination: Vector2) -> void:
	print("Starting position: ", start_position)
	print("Destination: ", destination)
	var path_array = establish_path(actor, start_position, destination)
	print(path_array)
	await walk_path(actor, path_array)
	update_actor_map(actor)
	EventBus.movement_complete.emit()

func convert_to_local(vec: Vector2):
	return tilemaps[0].local_to_map(tilemaps[0].to_local(vec))

func establish_path(actor: Character, start_position: Vector2, destination: Vector2) -> Array:
	var start_local_coords = convert_to_local(start_position)
	var end_local_coords = convert_to_local(destination)
	
	var blocked_cells = actors_map.values()
	
	blocked_cells.erase(start_local_coords)
	blocked_cells.erase(end_local_coords)
	
	for cell in blocked_cells:
		navigation.set_cell_disabled(cell, true)
	
	var path = navigation.get_best_path(start_local_coords, end_local_coords, actor.current_dir)
	
	for cell in blocked_cells:
		navigation.set_cell_disabled(cell, false)
	
	return path

func walk_path(actor: Character, path_array: Array) -> void:
	var dir: Vector2
	for step in path_array.size()-1:
		if path_array.size() == 0:
			continue
		
		dir = path_array[step].direction_to(path_array[step+1])
		actor.direction_change(dir)
		await actor.move(dir)

func _on_pc_move(cur_position: Vector2, dir: Vector2i):
	var local_pos = convert_to_local(cur_position)
	
	if pc.move_ray.is_colliding():
		if pc.move_ray.get_collider().is_in_group("Exits"):
			var exit: ExitArea = pc.move_ray.get_collider()
			if !exit.armed and !exit.lock_message.is_empty():
				print("Emit the request!")
				interaction_request.emit(exit.lock_message)
	
	actors_map[pc] = local_pos + dir

func lock_doors() -> void:
	print("Locking doors")
	for door in locked_doors:
		print("Going to lock this door: ", door, " in these doors ", locked_doors)
		door["door"].lock()
		if door["unlock"].all(func(c): return c.call()):
			door["door"].unlock()
