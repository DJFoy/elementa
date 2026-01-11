extends Node

@onready var main_menu: PackedScene = load("scenes/main_menu.tscn")

func _ready() -> void:
	var main_menu_init:= main_menu.instantiate()
	$World.add_child(main_menu_init)
	main_menu_init.connect("world_change_request", _on_world_change_request)

func _load_world(scene_path):
	for child in $World.get_children():
		child.queue_free()
	var world_scene = load(scene_path).instantiate()
	$World.add_child(world_scene)
	
	_connect_world_change_signals(world_scene)

func _connect_world_change_signals(root: Node) -> void:
	if root.has_signal("world_change_request"):
		root.world_change_request.connect(_on_world_change_request)
	
	for child in root.get_children():
		_connect_world_change_signals(child)

func _on_world_change_request(to_scene_path: String) -> void:
	_load_world(to_scene_path)

func _load_ui(scene_path):
	pass

func _on_ui_request(ui_path: String) -> void:
	pass

func _connect_ui_signals(root: Node) -> void:
	pass
