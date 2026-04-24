@tool
class_name ControlPanelMenuLoader
extends Node


@export var control_menu: PackedScene


func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	if control_menu:
		var new_control_menu: ControlPanelMenu = control_menu.instantiate()
		new_control_menu.xr_scene = owner
		ControlPanel.change_control_panel_menu(new_control_menu)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	
	if owner is not XRToolsSceneBase:
		warnings.append("Should be a child of a XRToolsSceneBase")
	
	return warnings
