extends Panel

var hovered = false
var dragging =  false
var copy = true
var initial_position: Vector2
@onready var tile_map = $"../TileMap"
var flip = 0
var input_points = [Vector2(0, 0), Vector2(0, 1)]


func _input(event):
	if event.is_action_pressed("shift") and dragging:
		tile_map.update_map(position + self.initial_position, 'testing', flip, self)
	elif event is InputEventMouseButton and hovered:
		if event.is_action_pressed("click") and dragging:
			self.stop_drag(event.position)
		elif event.is_action_pressed("click"):
			
			start_drag()
		elif event.is_action_pressed("right_click") and dragging:
			tile_map.clear_layer(2)
			self.queue_free()
			
	if event.is_action_pressed("rotate") and dragging:
		var rotated_90 = rotate_input_vectors(input_points, 90*flip)
		print(rotated_90)
		update_flip()
		tile_map.update_map_temp(position + self.initial_position, 'yee', flip)
		

	if event is InputEventMouseMotion and dragging:
		position = event.position - self.initial_position
		tile_map.update_map_temp(event.position, 'yee', flip)
		
	
func _on_mouse_entered():
	hovered = true
	
func start_drag():
	initial_position = get_local_mouse_position()
	if self.copy:
		self.clone()
		
	dragging = true
	
func stop_drag(location: Vector2i):
	
	dragging = false
	tile_map.update_map(location, 'testing', flip, self)
	self.queue_free()
	

func _on_mouse_exited():
	hovered = false # 

func clone():
	var other = self.duplicate()
	get_parent().add_child(other)
	return other
	
func update_flip():
	flip +=1
	if flip > 3:
		flip = 0

func rotate_input_vectors(original_input_points, angle: int) -> Array:
	# Define the original input points
	
	# Initialize rotated input points
	var rotated_input_points = []
	
	# Handle the rotations
	match angle:
		0:
			rotated_input_points = original_input_points
		90:
			rotated_input_points = [Vector2(0, 0), Vector2(1, 0)]
		180:
			rotated_input_points = [Vector2(1, 1), Vector2(1, 0)]
		270:
			rotated_input_points = [Vector2(0, 1), Vector2(1, 1)]
	return rotated_input_points
func rotate_output_vectors(original_input_points, angle: int) -> Array:
	# Define the original input points
	
	# Initialize rotated input points
	var rotated_input_points = []
	
	# Handle the rotations
	match angle:
		0:
			rotated_input_points = original_input_points
		90:
			rotated_input_points = [Vector2(0,1), Vector2(1, 1)]
		180:
			rotated_input_points = [Vector2(0, 0), Vector2(0, 1)]
		270:
			rotated_input_points = [Vector2(0, 0), Vector2(1, 0)]
	return rotated_input_points
