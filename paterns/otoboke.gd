class_name OtobokePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	house_walking(ghost, ghost.MOVEMENT_DURATION * 20)

	pass
