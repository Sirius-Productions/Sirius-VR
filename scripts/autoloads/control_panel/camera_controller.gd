class_name ControlPanelCameraController
extends CharacterBody3D


var speed = 5.0
var mouse_captured: bool = false
var can_move: bool = true
var can_rotate: bool = true

@onready var camera_rotation: Node3D = %CameraRotation
@onready var camera: Camera3D = %Camera3D


func _unhandled_input(event: InputEvent) -> void:
	if not can_rotate: return
	
	if event is InputEventMouseMotion and mouse_captured:
		camera_rotation.rotate_y(-event.relative.x * 0.001)
		camera.rotate_x(-event.relative.y * 0.001)


func _physics_process(_delta: float) -> void:
	if not can_move: return
	
	var y_dir := Input.get_axis("control_movement_down", "control_movement_up")
	velocity.y = y_dir * speed
	
	var input_dir := Input.get_vector("control_movement_left", "control_movement_right", "control_movement_backward", "control_movement_forward")
	var direction := (camera_rotation.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
