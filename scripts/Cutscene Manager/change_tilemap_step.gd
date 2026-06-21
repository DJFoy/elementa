extends CutsceneStep
class_name ChangeTileMapStep

@export var cell: Vector2i
@export var new_tile: Vector2i

enum Transform {
	NONE = 0,
	FLIP_H = TileSetAtlasSource.TRANSFORM_FLIP_H,
	FLIP_V = TileSetAtlasSource.TRANSFORM_FLIP_V,
	TRANSPOSE = TileSetAtlasSource.TRANSFORM_TRANSPOSE
}
@export var transform: Transform = Transform.NONE

var tilemap: TileMapLayer

func run(director) -> void:
	tilemap.set_cell(cell, 0, new_tile, transform)
