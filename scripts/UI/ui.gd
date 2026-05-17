extends CanvasLayer

var interact_scene = preload("uid://bd5yex4vadwcc")
var dialogue_scene = preload("uid://xlgquvpcpldn")
var game_menu = preload("uid://imfmklwsjtkd")

func _ready() -> void:
	EventBus.open_game_menu.connect(_on_game_menu_request)

func start_interact_ui(interaction_text):
	var interact := interact_scene.instantiate()
	add_child(interact)
	interact.process_text_array(interaction_text)

func npc_start_dialogue_ui(npc: Non_Player_Character):
	GameState.lock()
	var dialogue: Dialogue = dialogue_scene.instantiate()
	_connect_dialogue_signals(dialogue)
	add_child(dialogue)
	var npc_dialogue_id = npc.npc_resource.dialogue_map.resolve_dialogue()
	dialogue.dialogue_runner.StartDialogueForget(npc_dialogue_id)
	await dialogue.request_dialogue_end
	Global_World_State.one_time_dialogues.append(npc_dialogue_id)

func _connect_dialogue_signals(root: Node) -> void:
	if root.has_signal("request_dialogue_end"):
		root.request_dialogue_end.connect(_on_request_dialogue_end)

func _on_request_dialogue_end() -> void:
	for child in get_children():
		child.queue_free()
	GameState.unlock()
	GameState.interacting = false

func _cutscene_start_dialogue_ui(dialogue_id: String):
	GameState.lock()
	var dialogue := dialogue_scene.instantiate()
	_connect_dialogue_signals(dialogue)
	add_child(dialogue)
	dialogue.dialogue_runner.StartDialogueForget(dialogue_id)
	await dialogue.request_dialogue_end

func _on_game_menu_request() -> void:
	GameState.lock()
	GameState.interacting = true
	var gm: GameMenu = game_menu.instantiate()
	add_child(gm)
