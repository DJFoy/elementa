extends Control

signal skin_tone_selected(skin_index: int)

var skin_tones:= [
	Color(0.94, 0.77, 0.62),
	Color(0.81, 0.61, 0.47),
	Color(0.64, 0.43,0.32)
]

var skin_colour_choice:= 1

var selected_index := -1

func _ready() -> void:
	var container = $HBoxContainer
	
	for i in range(skin_tones.size()):
		var rect = ColorRect.new()
		rect.color = skin_tones[i]
		rect.custom_minimum_size = Vector2(20,20)
		rect.mouse_filter = Control.MOUSE_FILTER_STOP
		rect.name = str(i)
		rect.connect("gui_input", Callable(self, "_on_colour_clicked").bind(i))
		container.add_child(rect)
	
	update_highlight()

func _on_colour_clicked(event: InputEvent, index: int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		selected_index = index
		update_highlight()
		emit_signal("skin_tone_selected", index)
		skin_colour_choice = index + 1

func update_highlight():
	var container = $HBoxContainer
	for i in range(container.get_child_count()):
		var rect = container.get_child(i)
		if i == selected_index:
			rect.modulate = Color(1,1,1)
			rect.add_theme_stylebox_override("panel", _make_highlight_box())
		else:
			rect.remove_theme_stylebox_override("panel")

func _make_highlight_box() -> StyleBoxFlat:
	print("Making a box")
	var box = StyleBoxFlat.new()
	box.border_color = Color(1.0, 0.153, 0.082, 1.0)
	box.set_border_width_all(3)
	box.set_corner_radius_all(0)
	return box
