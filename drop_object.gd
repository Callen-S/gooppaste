extends Panel

var hovered = false
var dragging =  false
var initial_position: Vector2
@onready var tile_map = $"../TileMap"
var flip = 0
var tile_data = tile_object.new()

func _input(event):
	if event is InputEventMouseButton and hovered:
		# place tile
		if event.is_action_pressed("click") and dragging:
			self.stop_drag(event.position)
		# start dragging and copy
		elif event.is_action_pressed("click"):
			start_drag()
		# clear temp layer and delete self
		elif event.is_action_pressed("right_click") and dragging:
			tile_map.clear_layer(2)
			self.queue_free()
	
		
	# update location and render
	if event is InputEventMouseMotion and dragging:
		position = event.position - self.initial_position
		tile_map.place_tile_temp(event.position, 'yee', flip)
		
func _on_mouse_entered():
	hovered = true
	
func start_drag():
	initial_position = get_local_mouse_position()
	self.clone()
	dragging = true
	
func stop_drag(location: Vector2i):
	dragging = false
	tile_map.place_tile(location, 'testing', flip, self)
	self.queue_free()
	
	

func _on_mouse_exited():
	hovered = false #

func clone():
	var other = self.duplicate()
	other.connect('mouse_entered', other._on_mouse_entered)
	other.connect('mouse_exited', other._on_mouse_exited)
	get_parent().add_child(other)
	return other
	
