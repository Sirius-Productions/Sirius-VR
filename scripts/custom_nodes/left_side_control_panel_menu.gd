class_name LeftSideControlPanelMenu
extends Control


var xr_scene: XRToolsSceneBase


func _ready() -> void:
	ControlPanel.information_sent.connect(_information_recieved)


func change_scene(scene_path: String) -> void:
	xr_scene.load_scene(scene_path)


@warning_ignore("unused_parameter")
func _information_recieved(info: Dictionary) -> void: pass
