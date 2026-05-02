extends Control


@onready var rotation_mode_button: OptionButton = %RotationModeButton
@onready var movement_mode_button: OptionButton = %MovementModeButton
@onready var menu_tabs: TabContainer = %MenuTabs
@onready var close_menu_control: Control = %CloseMenuControl


func _ready() -> void:
	# Movement Mode Button
	movement_mode_button.clear()
	for mov_mode in PlayerManager.get_movement_modes():
		movement_mode_button.add_item(mov_mode.name, mov_mode.id)
	movement_mode_button.select(PlayerManager.movement_mode)
	
	# Initialize with default setting
	XRToolsUserSettings.snap_turning = false
	PlayerManager.controller_rotation = true


func _on_tab_container_tab_selected(tab: int) -> void:
	if not menu_tabs: return
	
	var close_menu_tab: int = menu_tabs.get_tab_idx_from_control(close_menu_control)
	if tab == close_menu_tab:
		PlayerManager.close_menu()


func _on_rotation_mode_button_item_selected(index: int) -> void:
	match index:
		0:
			PlayerManager.controller_rotation = false
		1:
			XRToolsUserSettings.snap_turning = false
			PlayerManager.controller_rotation = true
		2:
			XRToolsUserSettings.snap_turning = true
			PlayerManager.controller_rotation = true


func _on_movement_mode_button_item_selected(index: int) -> void:
	PlayerManager.movement_mode = movement_mode_button.get_item_id(index) as PlayerManager.MovementModes
