extends Node

@onready var main_menu: PackedScene = load("scenes/main_menu.tscn")

func _ready() -> void:
	var main_menu_init:= main_menu.instantiate()
	add_child(main_menu_init)
	main_menu_init.connect("new_game", _start_new_game)
	main_menu_init.connect("debug", _start_debug)

func _start_new_game():
	get_tree().change_scene_to_file("res://scenes/player_init.tscn")

func _start_debug():
	get_tree().change_scene_to_file("res://scenes/debug.tscn")
