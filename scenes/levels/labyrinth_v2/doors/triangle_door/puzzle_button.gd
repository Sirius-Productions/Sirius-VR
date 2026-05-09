class_name LabyrinthV2PuzzleButton
extends TextureButton


var mat: StandardMaterial3D:
	get():
		var mesh_in: MeshInstance3D = get_parent().get_parent().find_child("Screen")
		return mesh_in.get_surface_override_material(0)


func _ready() -> void:
	toggled.connect(func(toggle_on: bool) -> void:
		if toggle_on:
			mat.emission = Color.WHITE
			print("Toogle on %s" % name)
		else:
			mat.emission = Color.BLACK
			print("Toogle off %s" % name)
	)
