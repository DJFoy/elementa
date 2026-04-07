extends Location
@onready var bird: AnimatedCutscene = $NPCs/Bird
@onready var furniture: TileMapLayer = $TileMaps/Furniture
@onready var background: TileMapLayer = $TileMaps/Background



func _ready() -> void:
	bird.connect("open_window", _on_open_window_requested)
	SceneTransition.fade_in()
	
	await get_tree().create_timer(2).timeout
	bird.play_animation()
	

func _on_open_window_requested() -> void:
	background.set_cell(Vector2i(2,0), 0, Vector2i(11,8))
	furniture.set_cell(Vector2i(3,-2), 0, Vector2i(12,8))
