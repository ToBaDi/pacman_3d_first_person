class_name MachibusePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.set_in_house_walking_timer(0.01)
	ghost.active_in_house_walking_timer()
	ghost.start_tween()
	ghost.connect_tween()
	pass
