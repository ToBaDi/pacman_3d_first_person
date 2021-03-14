class_name OikakePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.add_rotation_task(180)
	ghost.add_movement_task(180, 3)
	ghost.start_tween()
	ghost.connect_tween()
	pass


static func _exit_house(_ghost : Ghost) -> void:
	pass


static func _enter_house(_ghost : Ghost) -> void:
	pass
