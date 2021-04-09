extends Area


export(Vector3) var destination : Vector3 = Vector3.ZERO


func _on_LeftTeleportToggle_area_entered(area : Area) -> void:
	area.teleport = destination
	pass
