extends Area


signal next_pos(pos)
signal tween_all_completed()


const MOVEMENT_DURATION : float = .5
const ROTATION_DURATION : float = .25
const FRONT_HOUSE_POS : Vector3 = Vector3(24, 0, 0)

export(Material) var material : Material
export(Material) var frightened_material : Material
export(Material) var frightened_white_material : Material
export(Vector3) var scatter_pos : Vector3

var target_pos : Vector3
var back_dir : float = 180
var teleport : Vector3 = Vector3.ZERO
var rot : int = 0
var rot_t : float = 1
var rot_quat : Quat = Quat.IDENTITY
var dont_go_up : bool = false
var is_in_house : bool = true
var is_frightened : bool = false
var is_eaten : bool = false
var start_game : FuncRef = FuncRef.new()
var enter_house : FuncRef = FuncRef.new()
var exit_house : FuncRef = FuncRef.new()
var tween_msg_bus : Array = []
var init_trans : Transform


func _init() -> void:
	start_game.set_function("_start_game")
	enter_house.set_function("_enter_house")
	exit_house.set_function("_exit_house")
	rot_quat.set_axis_angle(Vector3.RIGHT, deg2rad(90))

func _enter_tree() -> void:
	target_pos = scatter_pos
	init_trans = transform



func _ready() -> void:
	$Body.material_override = material
	$LeftMirror.material_override = material
	$RightMirror.material_override = material


func _process(_delta : float) -> void:
	var b : Quat = Quat.IDENTITY
	b.set_euler(Vector3(deg2rad(90), deg2rad(rot), 0))
	rot_quat = rot_quat.slerp(b, rot_t)
	$Body.transform.basis = Basis(rot_quat)
	$LeftMirror.transform.basis = Basis(rot_quat)
	$RightMirror.transform.basis = Basis(rot_quat)


func _on_Tween_tween_all_completed():
	emit_signal("tween_all_completed")
	if teleport:
		transform.origin = teleport
		teleport = Vector3.ZERO
	var f = tween_msg_bus.pop_front()
	if f:
		if f is FuncRef:
			f.call_func(self)
	else:
		var next_dir : int
		if is_frightened and not is_in_house:
			next_dir = pick_random_direction(find_valid_directions())
		else:
			next_dir = find_direction_closest_to_target(find_valid_directions())
		
		back_dir = (next_dir + 180) % 360
		add_rotation_task(next_dir)
		add_movement_task(next_dir)
	
	$Tween.start()
	pass


func _on_InHouseWalkingTimer_timeout() -> void:
	exit_house.call_func(self)
	pass


func _on_FrightenedTimer_timeout() -> void:
	is_frightened = false
	$Body.material_override = material
	$LeftMirror.material_override = material
	$RightMirror.material_override = material
	pass


func _on_FrightenedTimer2_timeout() -> void:
	var is_white : bool = false
	while not $FrightenedTimer.is_stopped():
		if is_white:
			$Body.material_override = frightened_material
			$LeftMirror.material_override = frightened_material
			$RightMirror.material_override = frightened_material
			is_white = false
		else:
			$Body.material_override = frightened_white_material
			$LeftMirror.material_override = frightened_white_material
			$RightMirror.material_override = frightened_white_material
			is_white = true
		yield(get_tree().create_timer(.5), "timeout")
	pass


func connect_tween() -> void:
	if not $Tween.is_connected("tween_all_completed", self, "_on_Tween_tween_all_completed"):
# warning-ignore:return_value_discarded
		$Tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed", [], Tween.CONNECT_DEFERRED)


func disconnect_tween() -> void:
	$Tween.disconnect("tween_all_completed", self, "_on_Tween_tween_all_completed")


func start_tween() -> void:
	$Tween.start()


func add_rotation_task(dir : int) -> void:
	rot = dir
	$Tween.interpolate_property(self, "rot_t",
		0, 1, ROTATION_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	pass


func add_movement_task(dir : int, steps : int = 2) -> void:
	var t : Vector3  = next_pos(dir, steps)
	$Tween.interpolate_property(self, "translation",
		null, t, MOVEMENT_DURATION,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	emit_signal("next_pos", t)
	pass


func add_go_to_position_task(pos : Vector3, duration : float) -> void:
	$Tween.interpolate_property(self, "translation",
		null, pos, duration,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	emit_signal("next_pos", pos)
	pass


func find_valid_directions() -> PoolIntArray:
	var valid_directions : PoolIntArray = []
	for i in range(1,5):
		var dir : int = (90 * i) % 360
		if back_dir == dir:
			continue
		if dont_go_up and dir == 90:
			continue
		$RayCast.global_transform = Transform.IDENTITY
		$RayCast.global_transform.origin = transform.origin
		$RayCast.set_cast_to(Vector3.BACK.rotated(Vector3.UP, deg2rad(dir)) * 3)
		$RayCast.force_raycast_update()
		if not $RayCast.get_collider():
			valid_directions.append(dir)
	return valid_directions


func find_direction_closest_to_target(valid_directions : PoolIntArray) -> int:
	var closest_direction : int = valid_directions[0]
	for i in valid_directions:
		var c_next_pos : Vector3 = next_pos(closest_direction)
		var i_next_pos : Vector3 = next_pos(i)
		if round(i_next_pos.distance_squared_to(target_pos)) < round(c_next_pos.distance_squared_to(target_pos)):
			closest_direction = i
	return closest_direction


func next_pos(dir : int, steps : int = 2) -> Vector3:
	return transform.origin + (Vector3.BACK.rotated(Vector3.UP, deg2rad(dir)) * steps)


func pick_random_direction(valid_directions : PoolIntArray) -> int:
	var r : int = RNG.rng.randi_range(0, valid_directions.size()-1)
	return valid_directions[r]


func go_frightened() -> void:
	is_frightened = true
	$Body.material_override = frightened_material
	$LeftMirror.material_override = frightened_material
	$RightMirror.material_override = frightened_material
	$FrightenedTimer.start()
	$FrightenedTimer2.start()
	pass


func go_eaten() -> void:
	is_frightened = false
	is_eaten = true
	$Body.material_override = material
	$LeftMirror.material_override = material
	$RightMirror.material_override = material
	$Body.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	$LeftMirror.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	$RightMirror.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	target_pos = FRONT_HOUSE_POS
	$FrightenedTimer.stop()
	$FrightenedTimer2.stop()
	pass


func exit_eaten() -> void:
	is_eaten = false
	$Body.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_ON
	$LeftMirror.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_ON
	$RightMirror.cast_shadow = GeometryInstance.SHADOW_CASTING_SETTING_ON
	pass


func your_in_front_of_the_house() -> void:
	if is_eaten:
		enter_house.call_func(self)
	pass


func active_in_house_walking_timer() -> void:
	$InHouseWalkingTimer.start()
	pass


func set_in_house_walking_timer(sec : float) -> void:
	$InHouseWalkingTimer.wait_time = sec
	pass


func stop() -> void:
	disconnect_tween()
	$Tween.stop_all()
	transform = init_trans
	back_dir = 270
	is_frightened = false
	is_eaten = false
	$Body.material_override = material
	$LeftMirror.material_override = material
	$RightMirror.material_override = material
	$Body.visible = true
	$LeftMirror.visible = true
	$RightMirror.visible = true
	$InHouseWalkingTimer.stop()
	$FrightenedTimer.stop()
	$FrightenedTimer2.stop()
