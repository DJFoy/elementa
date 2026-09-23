extends Control
class_name GameMenu

signal menu_close

func _ready() -> void:
	print("Opening the menu :)")

func _on_save_pressed() -> void:
	EventBus.save_menu_request.emit()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_menu"):
		get_viewport().set_input_as_handled()
		menu_close.emit()
		GameState.unlock()
		GameState.interacting = false
		queue_free()
