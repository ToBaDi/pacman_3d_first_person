class_name KimagurePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	house_walking(ghost, ghost.MOVEMENT_DURATION * 5)
	pass
