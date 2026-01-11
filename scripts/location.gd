extends Node2D
class_name Location

signal world_change_request(to_scene_path: String)

const PC_SCENE:= preload("res://scenes/pc.tscn")
@onready var pc: Player_Character
@onready var player_data: PlayerCreationData

@onready var scene_trans_load:= preload("res://scenes/scene_transition.tscn")
@onready var scene_trans: Node2D

@onready var spawns: Dictionary

@export var default_spawn: String

const INTERACT = preload("uid://bd5yex4vadwcc")
const DIALOGUE = preload("uid://xlgquvpcpldn")

var interactables: Dictionary
var dialogues: Dictionary

const FADE_IN = "fade_in"
const FADE_OUT = "fade_out"

func _ready() -> void:
	# Identify all the exits in the scene, and connect to the exit request signal
	for exit in get_tree().get_nodes_in_group("Exits"):
		exit.exit_requested.connect(_on_exit_requested)
	
	# Identify all of the spawns, and add to the spawn dict for the location
	for spawn in get_tree().get_nodes_in_group("Spawns"):
		spawns[spawn.spawn_name] = spawn
	
	# If no target spawn provided, revert to the default spawn specified in each location
	# A failsafe for debugging
	if !Global.target_spawn:
		Global.target_spawn = default_spawn
	
	# Bring in the player character and add to the scene
	pc = PC_SCENE.instantiate()
	add_child(pc)
	
	# Place the PC in the target spawn position
	# Currently set to a global variable
	pc.position = spawns[Global.target_spawn].get_position()
	
	# Clear out the global target spawn to prevent possible teleportation issues
	Global.target_spawn = ""
	# Spawn in the transition node
	scene_trans = scene_trans_load.instantiate()
	add_child(scene_trans)
	play_trans(FADE_IN)

func _on_exit_requested(from_scene: String, target_scene: String, target_spawn: String):
	trigger_exit(from_scene, target_spawn, target_scene)

func trigger_exit(from_scene: String, target_spawn: String, file_path: String):
	await play_trans(FADE_OUT)
	Global.prev_scene = from_scene
	Global.target_spawn = target_spawn
	
	world_change_request.emit(file_path)

func _process(delta: float) -> void:
	if Global.interacting:
		return
	if Input.is_action_just_pressed("interact"):
		if pc.interact_ray.is_colliding():
			if pc.interact_ray.get_collider().is_in_group("Interactable"):
				var interact = INTERACT.instantiate()
				add_child(interact)
				set_process_unhandled_input(false)
				# interact.get_node("CanvasLayer/TextBox").text = str(interactables[pc.interact_ray.get_collider()].size())
				interact.process_text_array(interactables[pc.interact_ray.get_collider()])
			if pc.interact_ray.get_collider().is_in_group("Dialogue"):
				var dialogue = DIALOGUE.instantiate()
				add_child(dialogue)
				set_process_unhandled_input(false)
				dialogue.process_text_array(dialogues[pc.interact_ray.get_collider()])
				#print(pc.interact_ray.get_collider())
				#print(dialogues[pc.interact_ray.get_collider()])


func play_trans(transition: String):
	var anim_player = scene_trans.get_node("AnimationPlayer")
	if transition == FADE_OUT:
		Global.lock()
		await get_tree().create_timer(0.5).timeout

	anim_player.play(transition)
	var anim_length = anim_player.get_animation(transition).length
	await get_tree().create_timer(anim_length).timeout
	
	if transition == FADE_IN:
		Global.unlock()
	
