extends Control

@onready var options_container: VBoxContainer = $Panel/ScrollContainer/OptionsContainer
@export var options: Array

func _ready() -> void:
	show_choices(["This is 1", "This is 2", "And this is 3! But when three gets big... and I mean really big."])

func show_choices(choices: Array):
	clear_choices()
	visible = true
	
	for choice in choices:
		var button := Button.new()
		button.text = choice
		button.theme_type_variation = "InteractButton"
		
		button.pressed.connect(func():
			_on_choice_selected(choice)
			)
		
		options_container.add_child(button)
		button.alignment = HORIZONTAL_ALIGNMENT_LEFT
		button.autowrap_mode = TextServer.AUTOWRAP_WORD
		
		if options_container.get_child_count() > 0:
			options_container.get_child(0).grab_focus()

func clear_choices():
	for child in options_container.get_children():
		child.queue_free()

func _on_choice_selected(choice):
	visible = false
	clear_choices()
	emit_signal("choice_selected", choice)
