class_name OikakePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.back_dir = 0
	ghost.is_in_house = false
	ghost.start_tween()
	ghost.connect_tween()
	pass


static func _enter_house_wait_exit(_ghost : Ghost) -> void:
	pass
