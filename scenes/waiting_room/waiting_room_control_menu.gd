extends ControlPanelMenu


@export_file("*tscn") var labyrinth_scene: String


func _on_labyrinthe_button_pressed() -> void:
	change_scene(labyrinth_scene)
