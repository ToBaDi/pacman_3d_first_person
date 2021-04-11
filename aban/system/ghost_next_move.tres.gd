class_name GhostNextMove
extends System


const MOVE_SPEED : float = .5
const ROTATE_SPEED :float = .2


func _ready() -> void:
	var err : int
	
	for g in data.ghosts:
		var ghost := g as Ghost
		ghost.next_pos = ghost.transform.origin
	
	err = data.connect("on_play", self, "start")
	if err:
		printerr("On GhsotMovement on_play Signal Connect Error: ", err)
	
	for i in data.ghosts_tweens.size():
		var tween := data.ghosts_tweens[i] as Tween
		err = tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed", [i])
		if err:
			printerr("On Ghosts Tweens Connecting Signal Error: ", err)


func _on_Tween_tween_all_completed(index : int) -> void:
	if data.is_on_play:
		next_move(index)

func start() -> void:
	for t in data.ghosts_tweens:
		# warning-ignore:return_value_discarded
		(t as Tween).start()


func next_move(index : int) -> void:
	var tween := data.ghosts_tweens[index] as Tween
	var ghost := data.ghosts[index] as Ghost
	var pos := ghost.global_transform.origin as Vector3
	var dir := data.ghosts_dir[index] as int
	var target := data.ghosts_targets[index] as Vector3
	
	var valid_directions : PoolIntArray = []
	for i in range(-1, 3):
		var td : int = i * 90
		if td == norm_angle(dir + 180):
			continue
		valid_directions.append(td)
#		if not ghost.ray_test(td):
	
	var closest_direction : int = find_direction_closest_to_target(valid_directions, pos, target)
	
	if closest_direction != dir:
		ghost.perv_basis = Basis.IDENTITY.rotated(Vector3.UP, deg2rad(dir))
		ghost.next_basis = Basis.IDENTITY.rotated(Vector3.UP, deg2rad(closest_direction))
		# warning-ignore:return_value_discarded
		tween.interpolate_method(ghost, "smooth_rotation", .0, 1.0, ROTATE_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	ghost.perv_pos = ghost.transform.origin
	var forward := Vector3.FORWARD.rotated(Vector3.UP, deg2rad(closest_direction))
	ghost.next_pos = ghost.next_pos + (forward * 2)
	# warning-ignore:return_value_discarded
	tween.interpolate_method(ghost, "move", .0, 1.0, MOVE_SPEED, Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	# warning-ignore:return_value_discarded
	tween.start()
	data.ghosts_dir[index] = closest_direction


static func norm_angle(angle : int) -> int:
	angle = angle % 360
	match angle:
		270:
			angle = -90
		-180:
			angle = 180
		-270:
			angle = 90
	return angle


static func find_direction_closest_to_target(
	valid_directions : PoolIntArray,
	in_pos : Vector3,
	in_target : Vector3) -> int:
	
	var pos := Vector3(in_pos.x, 0, in_pos.z)
	var target := Vector3(in_target.x, 0, in_target.z)
	
	var closest_direction : int = valid_directions[0]
	for second_dir in valid_directions.size():
		var first_pos := pos + Vector3.FORWARD.rotated(Vector3.UP, deg2rad(closest_direction))
		var second_pos := pos + Vector3.FORWARD.rotated(Vector3.UP, deg2rad(second_dir))
		var first_dis := int(stepify(first_pos.distance_squared_to(target), .5))
		var second_dis := int(stepify(second_pos.distance_squared_to(target), .5))
		if  second_dis < first_dis:
			closest_direction = second_dir
	return closest_direction
