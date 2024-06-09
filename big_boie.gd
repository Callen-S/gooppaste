extends  Node2D

# Variables to define grid properties
var columns := 4
var rows := 5
var panel_spacing := 1

# Preload the Panel script
var PanelScript := preload("res://magic_panel.gd")

func _ready():
	# Get the size of the Control node
	var control_size = 100
	# Calculate the size for each panel
	var panel_size = Vector2(100,100)

	for row in range(rows):
		for col in range(columns):
			var panel: Panel = Panel.new()
			# Add the panel to the scene tree
			
			# Set the size and position of the panel
			var new_style = StyleBoxFlat.new()
			new_style.set_bg_color(Color(1, 1, 0, 1))
			panel.set_size(Vector2(20, 20))
			panel.set("custom_styles/panel", new_style)
			panel.set_global_position(Vector2(
				col * (panel_size.x + panel_spacing+1000),
				row * (panel_size.y + panel_spacing)
			))
			# Attach the Panel script to each panel
			panel.set_script(PanelScript)
			panel.connect('mouse_entered', panel._on_mouse_entered)
			panel.connect('mouse_exited', panel._on_mouse_exited)
			self.add_child(panel)
