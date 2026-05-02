extends Node3D


@onready var default_menu_position: Marker3D = %DefaultMenuPosition
@onready var menu_viewport: Node3D = %MenuViewport
@onready var menu_function_pointer_left: XRToolsFunctionPointer = %MenuFunctionPointerLeft
@onready var menu_function_pointer_right: XRToolsFunctionPointer = %MenuFunctionPointerRight
@onready var movement_turn_right: XRToolsMovementTurn = %MovementTurnRight
@onready var function_teleport_left: XRToolsFunctionTeleport = %FunctionTeleportLeft
@onready var movement_direct_right: XRToolsMovementDirect = %MovementDirectRight


func _ready() -> void:
	menu_viewport.hide()
	PlayerManager.menu_closed.connect(_hide_menu)
	_update_settings()


func _on_left_hand_button_pressed(action_name: String) -> void:
	if action_name == "menu_button": _show_menu()


func _update_settings() -> void:
	# Update rotation mode
	movement_turn_right.enabled = PlayerManager.controller_rotation
	
	# Update movement mode
	match PlayerManager.movement_mode:
		PlayerManager.MovementModes.WALK:
			function_teleport_left.enabled = false
			movement_direct_right.enabled = true
		PlayerManager.MovementModes.TELEPORT:
			function_teleport_left.enabled = true
			movement_direct_right.enabled = false
		PlayerManager.MovementModes.BOTH:
			function_teleport_left.enabled = true
			movement_direct_right.enabled = true


func _show_menu() -> void:
	menu_viewport.global_position = default_menu_position.global_position
	menu_viewport.global_rotation = default_menu_position.global_rotation
	menu_viewport.rotation.z = 0.0
	menu_function_pointer_right.enabled = true
	menu_function_pointer_right.show_laser = XRToolsFunctionPointer.LaserShow.COLLIDE
	menu_viewport.show()


func _hide_menu() -> void:
	menu_function_pointer_right.enabled = false
	menu_function_pointer_left.enabled = false
	menu_function_pointer_right.show_laser = XRToolsFunctionPointer.LaserShow.HIDE
	menu_function_pointer_left.show_laser = XRToolsFunctionPointer.LaserShow.HIDE
	menu_viewport.hide()
