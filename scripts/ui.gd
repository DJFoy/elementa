extends CanvasLayer

var interact_scene = preload("uid://bd5yex4vadwcc")
var dialogue_scene = preload("uid://d2ahs8hoi2mp")

func _ready() -> void:
	pass

func start_interact_ui(interaction_text):
	var interact := interact_scene.instantiate()
	add_child(interact)
	interact.process_text_array(interaction_text)

func start_dialogue_ui(npc: Non_Player_Character):
	var dialogue := dialogue_scene.instantiate()
	add_child(dialogue)
	dialogue.dialogue_runner.StartDialogueForget(npc.npc_resource.dialogue_map.resolve_dialogue())
