extends Control
class_name Interact

@onready var text_box: RichTextLabel = $Panel/TextBox


# A screen that appears when interacting with objects. Should display text
# from the Location node based on the object being interacted with.
# The interaction will display various lines of text then close itself when
# all the text has been read

# Store the total number of text lines in array
@onready var n_text: int = 0
# Store the current text being displayed
@onready var n_cur: int = 0

# Store the text array from the Location node
@onready var local_text_array: Array

var printing_text:= false

var active_tween: Tween

func _ready() -> void:
	# Set the global state to interacting and lock character input
	Global.interacting = true
	Global.lock()

func parse_text(text_array: Array, n: int):
	# Take an array of text and remove the specified element
	return text_array[n]

func process_text_array(text_array: Array):
	n_text = text_array.size()
	local_text_array = text_array
	generate_text(local_text_array)

func generate_text(text_array: Array):
	text_box.text = parse_text(text_array, n_cur)
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
		else: 
			text_box.visible_ratio = 0
			generate_text(local_text_array)
