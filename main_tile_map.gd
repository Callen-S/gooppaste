extends TileMap

var gridsize = 50
var tile_location_map = {}
var tile_list = []
var neighbor_vectors = [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]


# Called when the node enters the scene tree for the first time.
func _ready():
	create_grid()
	
func create_grid():
	for x in gridsize:
		for y in gridsize:
			tile_location_map[str(Vector2(x,y))] = 'Base'
			set_cell(0, Vector2(x,y), 0, Vector2(0,0),0)	


func place_tile(location: Vector2i, type: String, flip, tile: Panel):
	var tile_obj = tile.tile_data
	var location_on_map = local_to_map(location)
	var close_panels = get_relevent_panel(position)
	if len(close_panels) > 0:
		determine_tile_orientation(location_on_map, close_panels, tile_obj)
	else:
		tile_obj.input_points = location_on_map
		tile_obj.output_points = location_on_map + Vector2i(0,1)
		
	
	if location_valid(location_on_map):
		set_cell(1, location_on_map,0, Vector2i(2,0))
		rotate_cell(1, location_on_map, 0, Vector2i(2,0),flip)
		tile_location_map[str(location_on_map)] = tile_obj
		tile_list.append(tile_obj)

		
func place_tile_temp(location: Vector2i, type: String, flip):
	self.clear_layer(2)
	var location_on_map = local_to_map(location)
	if location_valid(location_on_map):
		set_cell(2, location_on_map,0, Vector2i(2,0))
		

func get_relevent_panel(location: Vector2i) -> Array:
	var neighbors = []
	for neighbor_vector in neighbor_vectors:
		var potential_neighbor = neighbor_vector + location 
		if tile_location_map.has(str(potential_neighbor)):
			if tile_location_map[str(potential_neighbor)] != 'Base':
				neighbors.append(str(potential_neighbor))
	return neighbors
	
# returns the direction vector of a valid connection!
func determine_tile_orientation(location_on_map: Vector2i, sources: Array, new_panel: tile_object):
	var input_vectors = []
	for source in sources:
		for vector in source.output_ops:
			var cur_opt = vector + source.input_points
			if cur_opt == location_on_map and cur_opt != source.input_points:
				input_vectors.append(location_on_map - source.input_points)
				
	print(input_vectors)

		
func rotate_cell(layer, location_on_map, tile_source, tile, rotation_angle):
	if rotation_angle == 1:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_TRANSPOSE)
	elif rotation_angle == 2:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_V | TileSetAtlasSource.TRANSFORM_FLIP_H)
	elif rotation_angle == 3:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_V | TileSetAtlasSource.TRANSFORM_TRANSPOSE)
		
func location_valid(location: Vector2i):
	if location[0] < gridsize and location[1] < gridsize:
		return true
	else: return false
