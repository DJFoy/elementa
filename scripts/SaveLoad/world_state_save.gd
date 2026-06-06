extends Save
class_name WorldStateSave

# ---------------- LOADING ----------------

static func load(slot: String = "") -> WorldStateSave:
	return Save._load_impl("world_state", false, WorldStateSave, slot) as WorldStateSave

# --------------- SAVE DATA ---------------

@export var character: PlayerCreationData
@export var familiar: NPC_Resource

@export var chapter: String
@export var one_time_dialogues: Array
@export var items_collected: Array
@export var cutscenes: Array

@export var current_scene: String
@export var last_location: Vector2
