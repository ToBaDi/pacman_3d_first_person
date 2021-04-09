class_name OikakePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.set_in_house_walking_timer(0.1)
	ghost.back_dir = 0
	ghost.is_in_house = false
	ghost.start_tween()
	ghost.connect_tween()
	pass
