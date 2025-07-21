extends Node

@onready var main_menu: PackedScene = load("scenes/main_menu.tscn")

func _ready() -> void:
	var main_menu_init:= main_menu.instantiate()
	add_child(main_menu_init)
