extends Location


@onready var spawn_init: Marker2D = $EntryPoints/SpawnInit
@onready var spawn_stairs: Marker2D = $EntryPoints/SpawnStairs

@onready var drawer: Area2D = $Interactables/Drawer
@onready var window: Area2D = $Interactables/Window
@onready var bookcase: Area2D = $Interactables/Bookcase


func _ready() -> void:
	spawns = {
		"PlayerInit": spawn_init,
		"PCHome": spawn_stairs
	}
	super()
	if prev_scene == "PlayerInit":
		leave_trans_area()
	interactables  = {
		bookcase: ["Filled with lots of home made books"],
		drawer: ["Ah, my two pairs of underwear", "Dad really did spoil me this birthday"],
		window: ["I wish I could fly away"]
	}


func _on_exit_stairs_body_entered(body: Node2D) -> void:
	if body is PC:
		trigger_exit("PCBedroom", "res://scenes/chapter1/locations/pc_home.tscn")


func _on_exit_stairs_2_body_exited(body: Node2D) -> void:
	leave_trans_area()
