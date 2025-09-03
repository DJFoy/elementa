extends Control

@onready var npc := preload("res://scenes/npc.tscn")
@onready var george_sprite := preload("res://resources/character_sprite_tilesets/george_sprite.tres")
@onready var gigi_sprite := preload("res://resources/character_sprite_tilesets/gigi_sprite.tres")
@onready var roy_sprite := preload("res://resources/character_sprite_tilesets/roy_sprite.tres")
@onready var sheila_sprite := preload("res://resources/character_sprite_tilesets/sheila_sprite.tres")
@onready var matthias_sprite := preload("res://resources/character_sprite_tilesets/matthias_sprite.tres")
@onready var charlotte_sprite := preload("res://resources/character_sprite_tilesets/charlotte_sprite.tres")
@onready var damien_sprite := preload("res://resources/character_sprite_tilesets/damien_sprite.tres")
@onready var eliza_sprite := preload("res://resources/character_sprite_tilesets/eliza_sprite.tres")

@onready var npc_dict := {0: george_sprite, 1: gigi_sprite, 2: roy_sprite, 3:   sheila_sprite, 4: matthias_sprite, 5: charlotte_sprite, 6: damien_sprite, 7: eliza_sprite}
@onready var npc_move := {0: "NPC/walk_up", 1: "NPC/walk_down", 2: "NPC/walk_left", 3: "NPC/walk_right"}

var current_npc

func _on_npc_item_selected(index: int) -> void:
	print(index)
	print(npc_dict[index])
	if current_npc:
		print("Not working!")
		current_npc.get_node("Sprite2D").texture = npc_dict[index]


func _on_spawn_npc_pressed() -> void:
	if !current_npc:
		current_npc = npc.instantiate()
		add_child(current_npc)
		current_npc.position.x = 240
		current_npc.position.y = 135
		current_npc.get_node("Sprite2D").texture = npc_dict[0]


func _on_movement_options_item_selected(index: int) -> void:
	if current_npc:
		current_npc.get_node("AnimationPlayer").play(npc_move[index])


func _on_clear_pressed() -> void:
	if current_npc:
		current_npc.queue_free()


func _on_stop_pressed() -> void:
	if current_npc: 
		current_npc.get_node("AnimationPlayer").stop()
