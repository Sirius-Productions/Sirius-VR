extends Node


@export var labyrinth_size := Vector2(60.75, 60.75)


@onready var player: XROrigin3D = $"../XROrigin3D"
@onready var control_panel_menu_loader: ControlPanelMenuLoader = %ControlPanelMenuLoader
@onready var debug_sun: DirectionalLight3D = $DebugSun


func _ready() -> void:
	debug_sun.hide()
	debug_sun.queue_free()


func _physics_process(_delta: float) -> void:
	var player_position_2d := Vector2(player.global_position.x, player.global_position.z)
	var ppos_relative_to_labyrinth := player_position_2d + (labyrinth_size/2)
	var ppos_normalized := ppos_relative_to_labyrinth / labyrinth_size
	
	ControlPanel.send_information({
		"player_position": ppos_normalized,
		"player_rotation": player.global_rotation.y
	})
