class_name GhostPattern
extends Object


static func _start_game(_ghost : Ghost) -> void:
	pass


static func _enter_house_wait_exit(_ghost : Ghost) -> void:
	pass


static func make_func_ref(func_name : String) -> FuncRef:
	var func_ref : FuncRef = FuncRef.new()
	func_ref.set_instance(TweenMessages)
	func_ref.set_function(func_name)
	return func_ref


static func exit_house(ghost : Ghost) -> void:
	ghost.tween_msg_bus.append(make_func_ref("add_rotation_task_90"))
	ghost.tween_msg_bus.append(make_func_ref("back_dir_270"))
	ghost.tween_msg_bus.append(make_func_ref("add_go_to_position_task_x24"))
	ghost.tween_msg_bus.append(make_func_ref("is_in_house_false"))
	
	ghost.start_tween()
	ghost.connect_tween()
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
	exit_house(ghost)
	pass









