extends Node
class_name Navigation

var astar: AStar2D = AStar2D.new()
var tilemaps: Array

var cell_to_id := {}
var id_to_cell := {}

func get_tile_rules(cell: Vector2i) -> Dictionary:
	var rules = {
		"walkable": true,
		"blocked_from": []
	}
	
	for tilemap in tilemaps:
		var data = tilemap.get_cell_tile_data(cell)
		
		if data == null:
			continue
		
		if data.get_custom_data("solid") == true:
			rules.walkable = false
		
		var blocked_from = data.get_custom_data("blocked_from")
		if blocked_from:
			rules.blocked_from.append_array(blocked_from)
	
	return rules

func debug_tile(cell: Vector2i) -> void:
	var rules = get_tile_rules(cell)
	print("Cell: ", cell, " Rules: ", rules)

func build() -> void:
	print("Build Start!")
	var cells = get_all_used_cells()
	print("Cells found: ", cells.size())
	
	_register_points(cells)
	_connect_points(cells)

func get_all_used_cells() -> Array:
	var cells := {}
	
	for layer in tilemaps:
		for cell in layer.get_used_cells():
			cells[cell] = true
	
	return cells.keys()

func _register_points(cells: Array) -> void:
	var id := 0
	
	for cell in cells:
		cell_to_id[cell] = id
		id_to_cell[id] = cell
		
		astar.add_point(id, Vector2(cell))
		
		id += 1
		
func _connect_points(cells: Array) -> void:
	for cell in cells:
		var from_id = cell_to_id[cell]
		
		for dir in [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]:
			var neighbour = cell + dir
			
			if not cell_to_id.has(neighbour):
				continue
			
			if _can_move(neighbour, dir):
				astar.connect_points(
					from_id,
					cell_to_id[neighbour],
					false
				)

func _can_move(to_cell: Vector2i, dir: Vector2i) -> bool:
	var rules = get_tile_rules(to_cell)
	
	if rules.walkable == false:
		return false
	
	var dir_enum = _vec_to_dir(dir)
	
	if dir_enum in rules.blocked_from:
		return false
	
	return true

func _vec_to_dir(v: Vector2i):
	match v:
		Vector2i.UP: return "Up"
		Vector2i.RIGHT: return "Right"
		Vector2i.DOWN: return "Down"
		Vector2i.LEFT: return "Left"
	return ""
