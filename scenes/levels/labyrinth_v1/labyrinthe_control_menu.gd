extends ControlPanelMenu


@onready var opened_doors: Label = %OpenedDoors
@onready var timer: Timer = %Timer


var animating: bool = true


func _on_ouvrir_portes_vertes_pressed() -> void:
	if animating: return
	
	if LabyrintheMurChangeant.portes_ouvertes == LabyrintheMurChangeant.GroupesMurs.MURS_VERT:
		return
	
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_VERT)
	opened_doors.text = "Aucune"
	timer.start()
	animating = true


func _on_ouvrir_portes_bleues_pressed() -> void:
	if animating: return
	
	if LabyrintheMurChangeant.portes_ouvertes == LabyrintheMurChangeant.GroupesMurs.MURS_BLEU:
		return
	
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_BLEU)
	opened_doors.text = "Bleues"
	timer.start()
	animating = true


func _on_ouvrir_portes_rouges_pressed() -> void:
	if animating: return
	
	if LabyrintheMurChangeant.portes_ouvertes == LabyrintheMurChangeant.GroupesMurs.MURS_ROUGES:
		return
	
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_ROUGES)
	opened_doors.text = "Rouges"
	timer.start()
	animating = true


func _on_timer_timeout() -> void:
	animating = false
