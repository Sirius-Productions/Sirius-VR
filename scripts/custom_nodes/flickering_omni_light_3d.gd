@tool
extends OmniLight3D


@export var min_energy: float = 0.5
@export var max_energy: float = 1.8
@export var flickering_time: float = 0.1
@export_range(0.01, 1.0) var flickering_lerp_weight: float = 0.3


var timer := Timer.new()
var rdm_energy: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(_on_timeout)
	_on_timeout()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	light_energy = lerp(light_energy, rdm_energy, flickering_lerp_weight)


func _on_timeout() -> void:
	rdm_energy = randf_range(min_energy, max_energy)
	timer.start(flickering_time)
