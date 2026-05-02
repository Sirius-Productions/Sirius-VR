class_name LeftSideControlPanelMenu
extends Control


var xr_scene: XRToolsSceneBase


func change_scene(scene_path: String) -> void:
	xr_scene.load_scene(scene_path)
