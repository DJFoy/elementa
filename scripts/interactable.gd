extends Area2D

class_name Interactable

@export var text: Array

func _ready() -> void:
	add_to_group("Interactable")
	collision_layer = 2
