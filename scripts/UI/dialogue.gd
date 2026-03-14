extends Interact
class_name Dialogue

@onready var character_name: RichTextLabel = $Panel/CharacterName
@onready var panel: Panel = $Panel


@onready var active_char: String

#var dialogue_test:= [
	#["Dad", "Morning, " + PLAYER_DATA.name + ". How are you feeling?"],
	#["Dad", "Are you ready for your first day of work?"],
	#[PLAYER_DATA.name, "..."],
	#["Dad", "Hey, I know you had your heart set on that scholarship. Working as a servant in the manor won't be all that bad, though. At least you won't have to work in the mines like I did."],
	#["Option", ["Right... I get to watch people like Gigi and George become adventurers while I sit at home and dust their silverware", "Yeah. I guess it could be worse"]],
	#["Dad", "I'm sorry " + PLAYER_DATA.name + ". I know it's unfair that nobles are often the only ones that get to become adventurers. I would give you the money if we had it. But, I mean, we can't even afford a Familiar for the house..."]
#]


func parse_text(text_array: Array, n: int):
	# Take an array of text and remove the specified element
	active_char = text_array[n][0]
	print(active_char)
	return text_array[n][1]

func process_text_array(text_array: Array):
	n_text = text_array.size()
	print(n_text)
	local_text_array = text_array
	print(local_text_array)
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
		if printing_text:
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
		elif local_text_array[n_cur][0] == "Option":
			pass
		else:
			text_box.visible_ratio = 0
			generate_text(local_text_array)
