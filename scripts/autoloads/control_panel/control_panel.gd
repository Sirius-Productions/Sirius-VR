# ControlPanel
extends Node


signal information_sent(info: Dictionary[String, Variant])


@onready var control_panel_menu: Control = %ControlPanelMenu
@onready var camera_controller: ControlPanelCameraController = %CameraController
@onready var camera_3d: Camera3D = %Camera3D
@onready var right_side_container: TabContainer = %RightSideContainer
@onready var secondary_control_panel_menu: Control = %SecondaryControlPanelMenu
@onready var camera_rotation: Node3D = %CameraRotation


var custom_right_side_panel: bool = false:
	set(value):
		custom_right_side_panel = value
		if value:
			right_side_container.current_tab = 1
		else:
			right_side_container.current_tab = 0
var can_camera_controller_move: bool = true:
	set(value):
		can_camera_controller_move = value
		camera_controller.can_move = value
var can_camera_controller_rotate: bool = true:
	set(value):
		can_camera_controller_rotate = value
		camera_controller.can_rotate = value


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


func send_information(info: Dictionary[String, Variant]) -> void:
	information_sent.emit(info)


## If [param enable] is set to false, the secondary menu will be changed but the
## ControlPanel could still be set to Camera3D.
func change_secondary_panel_menu(new_menu: Control, enable: bool = true) -> void:
	for child in secondary_control_panel_menu.get_children():
		child.queue_free()
	
	if new_menu.get_parent():
		new_menu.reparent(secondary_control_panel_menu, false)
	else:
		secondary_control_panel_menu.add_child(new_menu)
	
	if enable:
		custom_right_side_panel = true


func fullscreen_left_side_menu() -> void:
	right_side_container.hide()


func disable_fullscreen() -> void:
	right_side_container.show()


func set_camera_controller_position(to: Vector3) -> void:
	camera_controller.global_position = to

func set_camera_controller_rotation(to: Vector3) -> void:
	camera_rotation.rotation.y = to.y
	camera_3d.rotation.x = to.x

func set_camerra_controller_fov(new_fov: float = 75.0) -> void:
	camera_3d.fov = new_fov

func set_camerra_controller_size(new_size: float = 20) -> void:
	camera_3d.size = new_size

func set_camera_controller_projection(projection_type := Camera3D.ProjectionType.PROJECTION_PERSPECTIVE)  -> void:
	camera_3d.projection = projection_type
