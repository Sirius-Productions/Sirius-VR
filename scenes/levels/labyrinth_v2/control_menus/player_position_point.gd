@tool
class_name LabyrinthPlayerPositonPoint
extends Control


var player_position: Vector2
var player_rotation: int
var time: float





func _physics_process(_delta: float) -> void:
	player_point.position = player_position * size - (player_point.size / 2.0)
	player_point.player
