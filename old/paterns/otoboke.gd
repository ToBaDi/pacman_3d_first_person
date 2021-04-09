class_name OtobokePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.set_in_house_walking_timer(ghost.MOVEMENT_DURATION * 20)
	ghost.active_in_house_walking_timer()
	ghost.start_tween()
	ghost.connect_tween()
	pass
