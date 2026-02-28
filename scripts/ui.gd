extends CanvasLayer

var interact_scene = preload("uid://bd5yex4vadwcc")
var dialogue_scene = preload("uid://xlgquvpcpldn")

func _ready() -> void:
	pass

func start_interact_ui(interaction_text):
	var interact := interact_scene.instantiate()
	add_child(interact)
	interact.process_text_array(interaction_text)

func npc_start_dialogue_ui(npc: Non_Player_Character):
	var dialogue := dialogue_scene.instantiate()
	_connect_dialogue_signals(dialogue)
	add_child(dialogue)
	dialogue.dialogue_runner.StartDialogueForget(npc.npc_resource.dialogue_map.resolve_dialogue())

func _connect_dialogue_signals(root: Node) -> void:
	if root.has_signal("request_dialogue_end"):
		root.request_dialogue_end.connect(_on_request_dialogue_end)

func _on_request_dialogue_end() -> void:
	for child in get_children():
		child.queue_free()
	Global.unlock()
	Global.interacting = false

func _cutscene_start_dialogue_ui(dialogue_id: String):
	var dialogue := dialogue_scene.instantiate()
	_connect_dialogue_signals(dialogue)
	add_child(dialogue)
	dialogue.dialogue_runner.StartDialogueForget(dialogue_id)
