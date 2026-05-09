extends Node3D


const SOLUTION = [true, false, true, false, false, true, true, false]


@onready var popup: Window = %Popup
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var focus_time: float = 2.0
@onready var door_base: LabyrinthV2DoorBase = $DoorBase
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var hand_sprite: Sprite3D = %HandSprite

@onready var pzl_b1: TextureButton = %PuzzleButton1
@onready var pzl_b2: TextureButton = %PuzzleButton2
@onready var pzl_b3: TextureButton = %PuzzleButton3
@onready var pzl_b4: TextureButton = %PuzzleButton4
@onready var pzl_b5: TextureButton = %PuzzleButton5
@onready var pzl_b6: TextureButton = %PuzzleButton6
@onready var pzl_b7: TextureButton = %PuzzleButton7
@onready var pzl_b8: TextureButton = %PuzzleButton8
@onready var puzzle: Node3D = %Puzzle


var hand_inside: bool = false
var opened := false
var puzzle_btns: Array[TextureButton]


func _ready() -> void:
	puzzle_btns = [pzl_b1, pzl_b2, pzl_b3, pzl_b4, pzl_b5, pzl_b6, pzl_b7, pzl_b8]
	puzzle.hide()
	popup.hide()
	
	for puzzle_btn:TextureButton in puzzle_btns:
		puzzle_btn.toggled.connect(_on_puzzle_button_toggled)


func _physics_process(delta: float) -> void:
	if opened: return
	
	if texture_progress_bar.value == 1.0:
		opened = true
		get_tree().create_tween().tween_property(hand_sprite, "material_override:emission", Color.WHITE, 0.5)
		get_tree().create_tween().tween_property(texture_progress_bar, "value", 0.0, 0.1)
		puzzle.show()
		ControlPanel.add_popup(popup)
		return
	
	if hand_inside:
		texture_progress_bar.value = clampf(texture_progress_bar.value + (0.5 * delta), 0.0, 1.0)
	else:
		texture_progress_bar.value = clampf(texture_progress_bar.value - (3 * delta), 0.0, 1.0)


func _on_puzzle_button_toggled(_toggle_on: bool) -> void:
	for i: int in puzzle_btns.size():
		print("btn %d pressed %s, should be %s" % [i, puzzle_btns[i].pressed, SOLUTION[i]])
		if puzzle_btns[i].button_pressed != SOLUTION[i]:
			return
	door_base.open_door()
	var tween := get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(hand_sprite, "material_override:emission", Color.BLACK, 0.5)
	for pzl_btn in puzzle_btns:
		tween.tween_property(pzl_btn.get_parent().get_parent().find_child("Screen").get_surface_override_material(0), "emission", Color.BLACK, 0.5)
	popup.queue_free()


func _on_hand_pose_area_area_entered(area: Area3D) -> void:
	if area.name == "RightHandArea":
		hand_inside = true


func _on_hand_pose_area_area_exited(area: Area3D) -> void:
	if area.name == "RightHandArea":
		hand_inside = false
