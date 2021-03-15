class_name GhostPattern
extends Object


static func _start_game(_ghost : Ghost) -> void:
	pass


static func _exit_house(ghost : Ghost) -> void:
	var add_rotation_task_90 : FuncRef = FuncRef.new()
	add_rotation_task_90.set_instance(TweenMessages)
	add_rotation_task_90.set_function("add_rotation_task_90")
	ghost.tween_msg_bus.append(add_rotation_task_90)
	
	var back_dir_270 : FuncRef = FuncRef.new()
	back_dir_270.set_instance(TweenMessages)
	back_dir_270.set_function("back_dir_270")
	ghost.tween_msg_bus.append(back_dir_270)
	
	var add_go_to_position_task_x24 : FuncRef = FuncRef.new()
	add_go_to_position_task_x24.set_instance(TweenMessages)
	add_go_to_position_task_x24.set_function("add_go_to_position_task_x24")
	ghost.tween_msg_bus.append(add_go_to_position_task_x24)
	
	ghost.start_tween()
	ghost.connect_tween()
	pass


static func _enter_house(_ghost : Ghost) -> void:
	pass


static func house_walking(ghost : Ghost, time : float) -> void:
	ghost.start_tween()
	ghost.connect_tween()
	yield(ghost.get_tree().create_timer(time), "timeout")
	ghost.target_pos = Vector3(18, 0, 0)
	while !(round(ghost.transform.origin.x) == 18 and round(ghost.transform.origin.z) == 0):
		yield(ghost.get_tree().create_timer(.1), "timeout")
	ghost.disconnect_tween()
	ghost.target_pos = ghost.scatter_pos
	_exit_house(ghost)
	pass









