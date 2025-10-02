extends Control

@onready var npc_opt: OptionButton = $DebugOptions/NPC

@onready var npc := preload("res://scenes/npc.tscn")
@onready var george_sprite := preload("res://resources/character_sprite_tilesets/george_sprite.tres")
@onready var gigi_sprite := preload("res://resources/character_sprite_tilesets/gigi_sprite.tres")
@onready var roy_sprite := preload("res://resources/character_sprite_tilesets/roy_sprite.tres")
@onready var sheila_sprite := preload("res://resources/character_sprite_tilesets/sheila_sprite.tres")
@onready var matthias_sprite := preload("res://resources/character_sprite_tilesets/matthias_sprite.tres")
@onready var charlotte_sprite := preload("res://resources/character_sprite_tilesets/charlotte_sprite.tres")
@onready var damien_sprite := preload("res://resources/character_sprite_tilesets/damien_sprite.tres")
@onready var eliza_sprite := preload("res://resources/character_sprite_tilesets/eliza_sprite.tres")
@onready var anne_sprite := preload("res://resources/character_sprite_tilesets/anne_sprite.tres")
@onready var anne_acc := preload("res://resources/character_sprite_tilesets/anne_acc_sprite.tres")
@onready var prof_olivia_sprite := preload("res://resources/character_sprite_tilesets/prof_olivia_sprite.tres")
@onready var kenny_sprite := preload("res://resources/character_sprite_tilesets/kenny_sprite.tres")
@onready var kenny_elf_sprite := preload("res://resources/character_sprite_tilesets/kenny_elf_sprite.tres")
@onready var timmy_sprite := preload("res://resources/character_sprite_tilesets/timmy_sprite.tres")

@onready var npc_dict := {
	0: george_sprite, 
	1: gigi_sprite, 
	2: roy_sprite,
	3: sheila_sprite, 
	4: matthias_sprite, 
	5: charlotte_sprite, 
	6: damien_sprite, 
	7: eliza_sprite, 
	8: anne_sprite,
	9: prof_olivia_sprite,
	10: kenny_sprite,
	11: kenny_elf_sprite,
	12: timmy_sprite
}
	
@onready var npc_acc_dict := {
	0: null, 
	1: null, 
	2: null, 
	3: null, 
	4: null, 
	5: null, 
	6: null, 
	7: null, 
	8: anne_acc,
	9: null,
	10: null,
	11: null,
	12: null
}

@onready var npc_move := {0: "NPC/walk_up", 1: "NPC/walk_down", 2: "NPC/walk_left", 3: "NPC/walk_right"}

var current_npc

func _on_npc_item_selected(index: int) -> void:
	if current_npc:
		print("Not working!")
		current_npc.get_node("Sprite2D").texture = npc_dict[index]
		current_npc.get_node("Accessory").texture = npc_acc_dict[index]

func _on_spawn_npc_pressed() -> void:
	if !current_npc:
		current_npc = npc.instantiate()
		add_child(current_npc)
		current_npc.position.x = 240
		current_npc.position.y = 135
		current_npc.get_node("Sprite2D").texture = npc_dict[npc_opt.selected]
		current_npc.get_node("Accessory").texture = npc_acc_dict[npc_opt.selected]


func _on_movement_options_item_selected(index: int) -> void:
	if current_npc:
		current_npc.get_node("AnimationPlayer").play(npc_move[index])


func _on_clear_pressed() -> void:
	if current_npc:
		current_npc.queue_free()


func _on_stop_pressed() -> void:
	if current_npc: 
		current_npc.get_node("AnimationPlayer").stop()
