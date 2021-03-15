class_name OikakePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.back_dir = 0
	ghost.start_tween()
	ghost.connect_tween()
	pass
