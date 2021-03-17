class_name KimagurePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.set_in_house_walking_timer(ghost.MOVEMENT_DURATION * 5)
	ghost.active_in_house_walking_timer()
	ghost.start_tween()
	ghost.connect_tween()
	pass
