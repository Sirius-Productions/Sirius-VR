extends ControlPanelMenu


func _on_ouvrir_portes_vertes_pressed() -> void:
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_VERT)


func _on_ouvrir_portes_bleues_pressed() -> void:
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_BLEU)


func _on_ouvrir_portes_rouges_pressed() -> void:
	LabyrintheMurChangeant.ouvrir_murs(LabyrintheMurChangeant.GroupesMurs.MURS_ROUGES)
