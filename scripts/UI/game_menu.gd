extends Control
class_name GameMenu

@onready var highlights: Control = $PanelContainer/Highlights
@onready var bestiary_highlight: TextureRect = $PanelContainer/Highlights/BestiaryHighlight
@onready var map_highlight: TextureRect = $PanelContainer/Highlights/MapHighlight

@onready var left_page: MarginContainer = $LeftPage
@onready var right_page: MarginContainer = $RightPage

@onready var bestiary_button: Button = $BestiaryButton
@onready var grimoire_button: Button = $GrimoireButton
@onready var inventory_button: Button = $InventoryButton
@onready var relationship_button: Button = $RelationshipButton
@onready var journal_button: Button = $JournalButton
@onready var map_button: Button = $MapButton


const BESTIARY_MENU_LEFT = preload("uid://ca12rqhaf52bg")
const BESTIARY_MENU_RIGHT = preload("uid://dblgrerbabgmn")

signal menu_close

func _ready() -> void:
	print("Opening the menu :)")
	bestiary_button.grab_focus.call_deferred()
	_on_bestiary_button_pressed()

func _on_save_pressed() -> void:
	EventBus.save_menu_request.emit()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_menu"):
		get_viewport().set_input_as_handled()
		menu_close.emit()
		GameState.unlock()
		GameState.interacting = false
		queue_free()


func _on_bestiary_button_focus_entered() -> void:
	bestiary_highlight.visible = true


func _on_bestiary_button_pressed() -> void:
	clear_pages()
	
	var left_page_content = BESTIARY_MENU_LEFT.instantiate()
	var right_page_content = BESTIARY_MENU_RIGHT.instantiate()
	
	left_page.add_child(left_page_content)
	right_page.add_child(right_page_content)

func _on_map_button_focus_entered() -> void:
	map_highlight.visible = true
	
func _on_tab_button_focus_exited() -> void:
	for tab in highlights.get_children():
		tab.visible = false

func clear_pages() -> void:
	for child in left_page.get_children():
		child.queue_free()
	
	for child in right_page.get_children():
		child.queue_free()


func _on_map_button_pressed() -> void:
	clear_pages()
