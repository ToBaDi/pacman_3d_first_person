class_name TweenMessages
extends Object


static func add_rotation_task_90(ghost : Ghost) -> void:
	ghost.add_rotation_task(90)

static func add_rotation_task_270(ghost : Ghost) -> void:
	ghost.add_rotation_task(270)

static func back_dir_270(ghost : Ghost) -> void:
	ghost.back_dir = 270

static func back_dir_90(ghost : Ghost) -> void:
	ghost.back_dir = 90

static func add_go_to_position_task_x24(ghost : Ghost) -> void:
	ghost.add_go_to_position_task(Vector3(24, ghost.transform.origin.y, ghost.transform.origin.z), 2)

static func add_go_to_position_task_x18(ghost : Ghost) -> void:
	ghost.add_go_to_position_task(Vector3(18, ghost.transform.origin.y, ghost.transform.origin.z), 2)

static func is_in_house_false(ghost : Ghost) -> void:
	ghost.is_in_house = false

static func is_in_house_true(ghost : Ghost) -> void:
	ghost.is_in_house = true

static func exit_eaten(ghost : Ghost) -> void:
	ghost.exit_eaten()

static func active_in_house_walking_timer(ghost : Ghost) -> void:
	ghost.active_in_house_walking_timer()




