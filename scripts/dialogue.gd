extends Interact
class_name Dialogue

@onready var character_name: RichTextLabel = $CanvasLayer/CharacterName

var active_char: String

const PLAYER_DATA = preload("res://saves/player_data.tres")

var dialogue_test:= [
	["Dad", "Hello, " + PLAYER_DATA.name + ". How are you feeling?"],
	["Dad", "Hope you slept well! I made my special waffles."],
	[PLAYER_DATA.name, "It's just bread, slightly warmed up."],
	["Action", "test_func"]
]

func test_func():
	print("Hahaha")
	
func parse_text(text_array: Array, n: int):
	# Take an array of text and remove the specified element
	active_char = text_array[n][0]
	return text_array[n][1]

func process_text_array(text_array: Array):
	n_text = text_array.size()
	local_text_array = text_array
	generate_text(local_text_array)

func generate_text(text_array: Array):
	text_box.text = parse_text(text_array, n_cur)
	character_name.text = active_char
	text_box.visible_ratio = 0
	
	if active_tween:
		active_tween.kill()
		active_tween = null
	
	active_tween = create_tween()
	active_tween.tween_property(
		text_box, 
		"visible_ratio", 
		1, 
		text_box.text.length()/14
	)
	printing_text = true
	
	active_tween.finished.connect(func ():
		printing_text = false
		active_tween = null
	)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if printing_text :
			if active_tween:
				active_tween.kill()
				active_tween = null
			text_box.visible_ratio = 1
			printing_text = false
			return
		n_cur += 1
		if n_cur == n_text:
			Global.interacting = false
			Global.unlock()
			get_parent().set_process_unhandled_input(true)
			self.queue_free()
		elif local_text_array[n_cur][0] == "Action":
			var func_name = local_text_array[n_cur][1]
			if has_method(func_name):
				call(func_name)
		else:
			text_box.visible_ratio = 0
			generate_text(local_text_array)
