class_name KimagurePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	house_walking(ghost, ghost.MOVEMENT_DURATION * 5)
	pass


static func _enter_house_wait_exit(_ghost : Ghost) -> void:
	pass
