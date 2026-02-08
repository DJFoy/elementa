extends CanvasLayer

@onready var interact_scene = preload("uid://bd5yex4vadwcc")

func _ready() -> void:
	pass

func start_interact_ui(interaction_text):
	var interact := interact_scene.instantiate()
	add_child(interact)
	interact.process_text_array(interaction_text)
