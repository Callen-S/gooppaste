extends TileMap

var gridsize = 50
var tile_location_map = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	create_grid()
	
func create_grid():
	for x in gridsize:
		for y in gridsize:
			tile_location_map[str(Vector2(x,y))] = 'Base'
			set_cell(0, Vector2(x,y), 0, Vector2(0,0),0)	


func place_tile(location: Vector2i, type: String, flip, tile: Panel):
	var location_on_map = local_to_map(location)
	
	if location_valid(location_on_map):
		set_cell(1, location_on_map,0, Vector2i(2,0))
		rotate_cell(1, location_on_map, 0, Vector2i(2,0),flip)
		tile_location_map[str(location_on_map)] = tile

		
func place_tile_temp(location: Vector2i, type: String, flip):
	self.clear_layer(2)
	var location_on_map = local_to_map(location)
	if  location_valid(location_on_map):
		set_cell(2, location_on_map,0, Vector2i(2,0))
		rotate_cell(2, location_on_map,0, Vector2i(2,0), flip)

		
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
