class_name LabyrinthV2DoorBase
extends Node3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open_door() -> void:
	animation_player.play("opening")
