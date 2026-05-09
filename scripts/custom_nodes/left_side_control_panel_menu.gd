class_name LeftSideControlPanelMenu
extends Control


var xr_scene: XRToolsSceneBase


func _ready() -> void:
	ControlPanel.information_sent.connect(_information_recieved)


func change_scene(scene_path: String) -> void:
	xr_scene.load_scene(scene_path)


@warning_ignore("unused_parameter")
func _information_recieved(info: Dictionary) -> void: pass


func _on_back_to_wait_room_pressed() -> void:
	change_scene("res://scenes/waiting_room/waiting_room.tscn")
