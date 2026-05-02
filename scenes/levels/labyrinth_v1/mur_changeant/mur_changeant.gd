class_name LabyrintheMurChangeant
extends Node3D


enum GroupesMurs { MURS_ROUGES, MURS_BLEU, MURS_VERT }


static var murs: Array[LabyrintheMurChangeant]
static var portes_ouvertes := GroupesMurs.MURS_ROUGES
var animating: bool = false


@export var groupe := GroupesMurs.MURS_ROUGES

@onready var animation_player: AnimationPlayer = $AnimationPlayer


static func ouvrir_murs(grp: GroupesMurs) -> void:
	portes_ouvertes = grp
	for mur in murs:
		mur._changer_etat()


func _enter_tree() -> void:
	murs.append(self)


func _ready() -> void:
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
