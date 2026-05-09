class_name LabyrintheMurChangeant
extends Node3D


enum GroupesMurs { MURS_ROUGES, MURS_BLEU, MURS_VERT }

const COLORS: Dictionary[GroupesMurs, Color] = {
	GroupesMurs.MURS_ROUGES: Color.RED,
	GroupesMurs.MURS_BLEU: Color.BLUE,
	GroupesMurs.MURS_VERT: Color.GREEN,
}


@export var groupe := GroupesMurs.MURS_ROUGES


static var murs: Array[LabyrintheMurChangeant]
static var portes_ouvertes := GroupesMurs.MURS_ROUGES
var animating: bool = false
var material: StandardMaterial3D
var show_color := false:
	set(value):
		show_color = value
		if csg_box_3d:
			material.albedo_color = COLORS[groupe] if value else Color.WHITE


@onready var csg_box_3d: CSGBox3D = $CSGBox3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


static func ouvrir_murs(grp: GroupesMurs) -> void:
	portes_ouvertes = grp
	for mur in murs:
		mur._changer_etat()

static func show_wall_color(turned_on: bool = true) -> void:
	for mur in murs:
		mur.show_color = turned_on


func _enter_tree() -> void:
	murs.append(self)


func _ready() -> void:
	csg_box_3d.material = csg_box_3d.material.duplicate()
	material = csg_box_3d.material as StandardMaterial3D
	
	if groupe == portes_ouvertes and animation_player.has_animation("ouvrir"):
		animation_player.play("ouvrir")
	else:
		position.y = 2.5
	
	animation_player.animation_finished.connect(func(_p): 
		animating = false
	)


func _exit_tree() -> void:
	if murs.find(self) != -1:
		murs.remove_at(murs.find(self))


func _changer_etat() -> void:
	if groupe == portes_ouvertes and animation_player.has_animation("ouvrir"):
		animation_player.play("ouvrir")
		animating = true
	elif animation_player.has_animation("fermer"):
		animation_player.play("fermer")
		animating = true
