extends Node3D


@onready var popup: Window = %Popup
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var focus_time: float = 2.0
@onready var door_base: LabyrinthV2DoorBase = $DoorBase
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var hand_sprite: Sprite3D = %HandSprite


var hand_inside: bool = false
var opened := false


func _physics_process(delta: float) -> void:
	if opened: return
	
	if texture_progress_bar.value == 1.0:
		opened = true
		ControlPanel.add_popup(popup)
		get_tree().create_tween().tween_property(hand_sprite, "material_override:emission", Color.WHITE, 0.5)
		texture_progress_bar.value = 0.0
		return
	
	if hand_inside:
		texture_progress_bar.value = clampf(texture_progress_bar.value + (0.5 * delta), 0.0, 1.0)
	else:
		texture_progress_bar.value = clampf(texture_progress_bar.value - (3 * delta), 0.0, 1.0)


func _on_hand_pose_area_area_entered(area: Area3D) -> void:
	if area.name == "RightHandArea":
		hand_inside = true


func _on_open_door_pressed() -> void:
	door_base.open_door()
	get_tree().create_tween().tween_property(hand_sprite, "material_override:emission", Color.BLACK, 0.5)
	popup.queue_free()


func _on_hand_pose_area_area_exited(area: Area3D) -> void:
	if area.name == "RightHandArea":
		hand_inside = false
