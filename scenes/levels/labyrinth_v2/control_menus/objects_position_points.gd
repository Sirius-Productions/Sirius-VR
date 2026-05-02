@tool
class_name LabyrinthObjectsPositionPoints
extends Control


var objects_positions: Dictionary[int, Dictionary]
var time: float


func _draw() -> void:
	pass


func _physics_process(_delta: float) -> void:
	queue_redraw()
