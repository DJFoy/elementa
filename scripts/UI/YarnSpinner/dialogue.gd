extends Control
class_name Dialogue

@export var line_presenter: Control
@export var dialogue_runner: DialogueRunner

signal request_next_line
signal request_dialogue_end

func _ready() -> void:
	GameState.interacting = true
	line_presenter.connect("dialogue_complete", _on_dialogue_complete)
	dialogue_runner.AddCommandHandlerCallable("update_gamestate", _yarnspinner_update_gamestate)
	_sync_game_and_yarn()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("request_next_line")
		get_viewport().set_input_as_handled()

func _on_dialogue_complete() -> void:
	emit_signal("request_dialogue_end")

func _sync_game_and_yarn() -> void:
	var vars = dialogue_runner.variableStorage
	vars.SetValue("$playerName", Global_World_State.character.name)
	vars.SetValue("$hatedFood", Global_World_State.character.dislikes)
	vars.SetValue("$lovedFood", Global_World_State.character.likes)

func _sync_yarn_and_game() -> void:
	var vars = dialogue_runner.variableStorage
	Global_World_State.familiar = vars.GetVariantValue("$chosen_familiar")

func _yarnspinner_update_gamestate(key, value) -> void:
	for prop in Global_World_State.get_property_list():
		if prop.name == key:
			if type_string(typeof(Global_World_State[key])) == "String":
				Global_World_State[key] = value
				print("Set the following key, ", key, " as this value: ", value)
				return
			if type_string(typeof(Global_World_State[key])) == "Array":
				Global_World_State[key].append(value)
				print("Appended %s to the array %s" % [value, key])
				return
	printerr("Requested key, %s, does not exist in Global_World_State" % key)
	return
