# PlayerManager
extends Node


#region Settings Signals
signal settings_changed
signal menu_closed
#endregion


#region Settings Enums
enum MovementModes { WALK, TELEPORT, BOTH }
#endregion


#region Settings Variables
var movement_mode := MovementModes.BOTH:
	set = _set_movement_mode
var controller_rotation: bool = true:
	set = _set_controller_rotation
#endregion


func close_menu() -> void:
	menu_closed.emit()


#region Settings Helper Functions
# Settings Var Setters
func _set_movement_mode(new_value: MovementModes) -> void:
	movement_mode = new_value
	settings_changed.emit()

func _set_controller_rotation(new_value: bool) -> void:
	controller_rotation = new_value
	settings_changed.emit()

# Settings Enums Getters
func get_movement_modes() -> Array[Dictionary]:
	return [
		{ "name": "Marcher", "id": MovementModes.WALK },
		{ "name": "Téléportation", "id": MovementModes.TELEPORT },
		{ "name": "Les deux", "id": MovementModes.BOTH },
	]
#endregion
