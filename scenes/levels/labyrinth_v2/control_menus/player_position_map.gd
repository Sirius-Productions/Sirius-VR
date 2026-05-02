@tool
class_name LabyrinthMap
extends Control


@export var player_position: Vector2
@export var player_rotation: float


@onready var player_positon_point: LabyrinthPlayerPositonPoint = %PlayerPositonPoint
@onready var player_point: TextureRect = %PlayerPoint


var time: float = 0


func _ready() -> void:
	ControlPanel.information_sent.connect(_information_recieved)


func _information_recieved(info: Dictionary) -> void:
	if info.has("player_position"):
		if info.player_position is Vector2:
			player_position = info.player_position
	
	if info.has("player_rotation"):
		if info.player_rotation is float:
			player_rotation = info.player_rotation


func _physics_process(delta: float) -> void:
	time += delta
	player_point.position = player_position * size - (player_point.size/2.0)
	player_point.rotation = player_rotation
