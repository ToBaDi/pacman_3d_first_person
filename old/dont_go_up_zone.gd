extends Area



func _on_DontGoUpZone_area_entered(area : Area) -> void:
	if area is Ghost:
		area.dont_go_up = true
	pass


func _on_DontGoUpZone_area_exited(area : Area) -> void:
	if area is Ghost:
		area.dont_go_up = false
	pass
