extends Control

@onready var dialogue_runner: DialogueRunner = $YarnSpinnerCanvasLayer/DialogueRunner
@onready var line_presenter_button_handler: Control = $YarnSpinnerCanvasLayer/LinePresenter/LinePresenterButtonHandler

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if line_presenter_button_handler._displayComplete:
			dialogue_runner.RequestNextLine()
		else:
			dialogue_runner.RequestHurryUpLine()
