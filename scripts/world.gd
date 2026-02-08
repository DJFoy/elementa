extends Node2D

@onready var main_menu: PackedScene = load("scenes/UI/main_menu.tscn")
@onready var ui: CanvasLayer = $"../UI"


func _ready() -> void:
	var main_menu_init:= main_menu.instantiate()
	add_child(main_menu_init)
	main_menu_init.connect("world_change_request", _on_world_change_request)

func _load_world(scene_path):
	for child in get_children():
		child.queue_free()
	var world_scene = load(scene_path).instantiate()
	add_child(world_scene)
	
	_connect_world_change_signals(world_scene)
	_connect_interact_signals(world_scene)

func _connect_world_change_signals(root: Node) -> void:
	if root.has_signal("world_change_request"):
		root.world_change_request.connect(_on_world_change_request)
	
	for child in root.get_children():
		_connect_world_change_signals(child)

func _on_world_change_request(to_scene_path: String) -> void:
	_load_world(to_scene_path)

func _connect_interact_signals(root: Node) -> void:
	if root.has_signal("interaction_request"):
		root.interaction_request.connect(_on_interact_request)
	
	for child in root.get_children():
		_connect_interact_signals(child)


func _on_interact_request(interaction_text: Array):
	ui.start_interact_ui(interaction_text)
