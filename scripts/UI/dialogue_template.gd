extends Control

@onready var dialogue_runner: DialogueRunner = $YarnSpinnerCanvasLayer/DialogueRunner
@onready var line_presenter_button_handler: Control = $YarnSpinnerCanvasLayer/LinePresenter/LinePresenterButtonHandler
@onready var character_name_text: RichTextLabel = $YarnSpinnerCanvasLayer/LinePresenter/PresenterControl/CharacterNameText

@onready var store_prev_name: String

func _ready() -> void:
	Global.interacting = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if line_presenter_button_handler._displayComplete:
			dialogue_runner.RequestNextLine()
		else:
			dialogue_runner.RequestHurryUpLine()
		get_viewport().set_input_as_handled()
