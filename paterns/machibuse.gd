class_name MachibusePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.add_rotation_task(90)
	ghost.add_go_to_position_task(Vector3(24, 0, 0), 2)
	ghost.start_tween()
	yield(ghost.get_tree().create_timer(2), "timeout")
	ghost.add_rotation_task(180)
	ghost.add_go_to_position_task(Vector3(24, 0, -3), ghost.MOVEMENT_DURATION)
	ghost.start_tween()
	ghost.connect_tween()
	pass


static func _exit_house(_ghost : Ghost) -> void:
	pass


static func _enter_house(_ghost : Ghost) -> void:
	pass
