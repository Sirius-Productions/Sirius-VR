extends Node


@onready var control_panel_menu: Control = %ControlPanelMenu


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.physical_keycode == KEY_F8:
			get_tree().quit()


func change_control_panel_menu(new_menu: Control) -> void:
	for child in control_panel_menu.get_children():
		child.queue_free()
	
	if new_menu.get_parent():
		new_menu.reparent(control_panel_menu, false)
	else:
		control_panel_menu.add_child(new_menu)
