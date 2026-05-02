extends LeftSideControlPanelMenu


@export_file("*tscn") var labyrinth_scene: String
@export_file("*tscn") var labyrinth_v2_scene: String


func _on_labyrinthe_button_pressed() -> void:
	change_scene(labyrinth_scene)


func _on_labyrinthe_v_2_button_pressed() -> void:
	change_scene(labyrinth_v2_scene)
