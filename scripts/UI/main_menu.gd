extends Control


func _ready() -> void:
	SceneTransition.fade_in()


func _on_new_game_pressed() -> void:
	EventBus.world_change_request.emit("res://scenes/UI/player_init.tscn")


func _on_load_game_pressed() -> void:
	EventBus.load_menu_request.emit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_debug_pressed() -> void:
	EventBus.world_change_request.emit("res://scenes/UI/debug.tscn")
