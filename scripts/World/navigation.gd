extends Node
class_name Navigation

var astar: AStar2D = AStar2D.new()
var tilemaps: Array

var cell_to_id := {}
var id_to_cell := {}

enum Dir {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

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

func build() -> void:
	var cells = get_all_used_cells()
	
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
		for dir in Dir.values():
			var key = [cell, dir]
			cell_to_id[key] = id
			id_to_cell[id] = key
		
			astar.add_point(id, Vector2(cell))
		
			id += 1
		
func _connect_points(cells: Array) -> void:
	for cell in cells:
		for from_dir in Dir.values():
			var from_id = cell_to_id[[cell, from_dir]]
			
			for neighbour_dir in Dir.values():
				var neighbour = cell + _dir_to_vec(neighbour_dir)
				
				if not cell_to_id.has([neighbour, neighbour_dir]):
					continue
				
				if not _can_move(cell, neighbour, _dir_to_vec(neighbour_dir)):
					continue
				
				var to_id = cell_to_id[[neighbour, neighbour_dir]]
				
				var cost := 1.0
				
				if from_dir != neighbour_dir:
					cost += 4
				
				astar.connect_points(from_id, to_id, false)
				astar.set_point_weight_scale(to_id, cost)

func _can_move(from_cell: Vector2i, to_cell: Vector2i, dir: Vector2i) -> bool:
	var from_rules = get_tile_rules(from_cell)
	var to_rules = get_tile_rules(to_cell)
	
	if to_rules.walkable == false:
		return false
	
	var dir_from_enum = _vec_to_str(dir)
	var dir_to_enum = _vec_to_str(-dir)
	
	if dir_from_enum in from_rules.blocked_from:
		return false
	elif dir_to_enum in to_rules.blocked_from:
		return false
	
	return true

func _vec_to_str(v: Vector2i) -> String:
	match v:
		Vector2i.UP: return "Up"
		Vector2i.RIGHT: return "Right"
		Vector2i.DOWN: return "Down"
		Vector2i.LEFT: return "Left"
	return ""

func _dir_to_vec(dir: int) -> Vector2i:
	match dir:
		Dir.UP: return Vector2i.UP
		Dir.DOWN: return Vector2i.DOWN
		Dir.RIGHT: return Vector2i.RIGHT
		Dir.LEFT: return Vector2i.LEFT
	return Vector2i.ZERO
