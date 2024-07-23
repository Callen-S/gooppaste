extends  Node2D

# Variables to define grid properties
var columns := 2
var rows := 8
var panel_spacing := 10
var off_set := 900
# Preload the Panel script
var PanelScript := preload("res://drop_object.gd")

func _ready():
	# Get the size of the Control node
	var control_size = 200
	# Calculate the size for each panel
	var panel_size = Vector2(50,50)

	for row in range(rows):
		for col in range(columns):
			var panel: Panel = Panel.new()
			var new_style = StyleBoxFlat.new()
			new_style.set_bg_color(Color(1, 1, 0, 1)) 
			panel.set_size(panel_size)
			panel.set("custom_styles/panel", new_style)
			panel.set_global_position(Vector2(
				col * (panel_size.x + panel_spacing) + off_set,
				row * (panel_size.y + panel_spacing)
			))
			# Attach the Panel script to each panel
			panel.set_script(PanelScript)
			panel.connect('mouse_entered', panel._on_mouse_entered)
			panel.connect('mouse_exited', panel._on_mouse_exited)
			self.add_child(panel)
