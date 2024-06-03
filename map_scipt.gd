extends TileMap

var gridsize = 50
var dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in gridsize:
		for y in gridsize:
			dict[str(Vector2(x,y))] = 'Base'
			set_cell(0, Vector2(x,y), 1, Vector2(0,0),0)
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func update_map(location: Vector2i, type: String, flip, tile):
	var location_on_map = local_to_map(location)
	print(location_on_map)
	if location_on_map[0] < gridsize and location_on_map[1] < gridsize :
		set_cell(1, location_on_map,0, Vector2i(0,0))
		rotate_cell(1, location_on_map, 0, Vector2i(0,0),flip)
		dict[str(location_on_map)] = tile
	
	# If tile is not already flipped, flip it.
	
		
func update_map_temp(location: Vector2i, type: String, flip):
	self.clear_layer(2)
	var location_on_map = local_to_map(location)
	print(location_on_map)
	if location_on_map[0] < gridsize and location_on_map[1] < gridsize :
		set_cell(2, location_on_map,0, Vector2i(0,0))
		rotate_cell(2, location_on_map,0, Vector2i(0,0), flip)
		
func rotate_cell(layer, location_on_map, tile_source, tile, rotation_angle):
	print(rotation_angle)
	if rotation_angle == 1:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_H | TileSetAtlasSource.TRANSFORM_TRANSPOSE)
	elif rotation_angle == 2:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_V | TileSetAtlasSource.TRANSFORM_FLIP_H)
	elif rotation_angle == 3:
		set_cell(layer, location_on_map,tile_source, tile,0 | TileSetAtlasSource.TRANSFORM_FLIP_V | TileSetAtlasSource.TRANSFORM_TRANSPOSE)
		
