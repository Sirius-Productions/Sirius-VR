extends Control


var mouse_inside: bool = false

var zoom_fov := 75.0:
	set(value):
		zoom_fov = value
		camera_3d.fov = value
		zoom_bar.value = value
		zoom_value_label.text = "%.1f fov" % value

var movement_speed := 5.0:
	set(value):
		movement_speed = value
		camera_controller.speed = value
		speed_bar.value = value
		speed_value_label.text = "%.1f m/s" % value


@onready var camera_controller: CharacterBody3D = %CameraController
@onready var camera_3d: Camera3D = %Camera3D

@onready var zoom_bar: ProgressBar = %ZoomBar
@onready var zoom_value_label: Label = %ZoomValueLabel
@onready var speed_bar: ProgressBar = %SpeedBar
@onready var speed_value_label: Label = %SpeedValueLabel


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			print('right btn')
			if event.is_pressed() and mouse_inside:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				camera_controller.mouse_captured = true
			else:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				if camera_controller.mouse_captured:
					camera_controller.mouse_captured = false
	
	if event is InputEventKey:
		if event.physical_keycode == KEY_F8:
			get_tree().quit()


func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false


func _on_gui_input(event: InputEvent) -> void:
	_unhandled_input(event)
	if camera_controller.mouse_captured:
		camera_controller._unhandled_input(event)
