extends Location


@onready var drawer: Area2D = $Interactables/Drawer
@onready var window: Area2D = $Interactables/Window
@onready var bookcase: Area2D = $Interactables/Bookcase


func _ready() -> void:
	# Adding failsafe to the inherited location scenes as spawn is no longer based on prev_scene but intended spawn
	super()
	if Global.target_spawn == "pc_bedroom_bed_01":
		for exit in get_tree().get_nodes_in_group("Exits"):
			exit.armed = true
			
	interactables  = {
		bookcase: ["Filled with lots of home made books"],
		drawer: ["Ah, my two pairs of underwear", "Dad really did spoil me this birthday"],
		window: ["I wish I could fly away"]
	}
