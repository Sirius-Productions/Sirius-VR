@tool
class_name ControlPanelMenuLoader
extends Node


@export var left_side_control_menu: PackedScene

@export_group("Camera Controller Settings")
## The [param position] of the [b]ControlPanel[/b]'s [Camera3D].
@export var camera_position: Vector3:
	set(value):
		camera_position = value
		ControlPanel.set_camera_controller_position(value)
## The [param rotation] of the [b]ControlPanel[/b]'s [Camera3D].
@export_custom(PROPERTY_HINT_NONE, "radians_as_degrees") var camera_rotation: Vector3 = Vector3(-PI/2.0, 0, 0):
	set(value):
		camera_rotation = value
		ControlPanel.set_camera_controller_rotation(value)
## The [param fov] of the [b]ControlPanel[/b]'s [Camera3D].
@export_range(1, 179, 1.0, "degrees") var camera_fov: float = 75:
	set(value):
		camera_fov = value
		ControlPanel.set_camerra_controller_fov(value)
## The [param size] of the [b]ControlPanel[/b]'s [Camera3D]. (Used if the
## projection is set to Orthogonal)
@export_range(0.001, 100, 0.001, "suffix:m") var camera_size: float = 30:
	set(value):
		camera_size = value
		ControlPanel.set_camerra_controller_size(value)
## The [param projection] of the [b]ControlPanel[/b]'s [Camera3D].
@export var camera_projection := Camera3D.ProjectionType.PROJECTION_PERSPECTIVE:
	set(value):
		camera_projection = value
		ControlPanel.set_camera_controller_projection(value)
## Wether the [b]ControlPanel[/b]'s CameraController can move in its 3D Space.
@export var controller_can_move := true:
	set(value):
		controller_can_move = value
		ControlPanel.can_camera_controller_move = value
## Wether the [b]ControlPanel[/b]'s [ControlPanelCameraController]'s [Camera3D] can be rotated by the player's mouse.
@export var controller_can_rotate_view := true:
	set(value):
		controller_can_rotate_view = value
		ControlPanel.can_camera_controller_rotate = value

@export_group("Custom Right Side Panel")
## If [code]true[/code], the  [b]ControlPanel[/b]'s CameraController will be
## replaced by your custom scene.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "Test group") var use_custom_right_side_panel := false:
	set(value):
		use_custom_right_side_panel = value
		ControlPanel.custom_right_side_panel = value
@export var right_side_scene: PackedScene


func _ready() -> void:
	if Engine.is_editor_hint(): return
	
	if left_side_control_menu:
		var new_control_menu: LeftSideControlPanelMenu = left_side_control_menu.instantiate()
		new_control_menu.xr_scene = owner
		ControlPanel.change_control_panel_menu(new_control_menu)
	
	if not use_custom_right_side_panel:
		ControlPanel.custom_right_side_panel = false
	elif right_side_scene:
		var new_right_side_menu: RightSideControlPanelMenu = right_side_scene.instantiate()
		new_right_side_menu.xr_scene = owner
		ControlPanel.change_secondary_panel_menu(new_right_side_menu)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	
	if owner is not XRToolsSceneBase:
		warnings.append("Should be a child of a XRToolsSceneBase")
	
	return warnings
