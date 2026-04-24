extends Node


const WAITING_ROOM_CONTROL_MENU: PackedScene = preload("uid://d3dr0js44dd1b")


func _ready() -> void:
	ControlPanel.change_control_panel_menu(WAITING_ROOM_CONTROL_MENU.instantiate())
