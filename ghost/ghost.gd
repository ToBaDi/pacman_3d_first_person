class_name Ghost
extends Area


signal next_pos(pos)
signal tween_all_completed()


const MOVEMENT_DURATION : float = .5
const ROTATION_DURATION : float = .25

export(Material) var material : Material
export(Vector3) var scatter_pos : Vector3

var target_pos : Vector3
var back_dir : float = 180
var teleport : Vector3 = Vector3.ZERO
var rot : int = 0
var rot_t : float = 1
var rot_quat : Quat = Quat.IDENTITY
var dont_go_up : bool = false
var is_in_house : bool = true
var start_game : FuncRef = FuncRef.new()
var enter_house : FuncRef = FuncRef.new()
var exit_house : FuncRef = FuncRef.new()
var tween_msg_bus : Array = []


func _init() -> void:
	start_game.set_function("_start_game")
	enter_house.set_function("_enter_house")
	exit_house.set_function("_exit_house")
	rot_quat.set_axis_angle(Vector3.RIGHT, deg2rad(90))


func _enter_tree() -> void:
	target_pos = scatter_pos


func _ready() -> void:
	if material:
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



func connect_tween() -> void:
	if not $Tween.is_connected("tween_all_completed", self, "_on_Tween_tween_all_completed"):
# warning-ignore:return_value_discarded
		$Tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed", [], Tween.CONNECT_DEFERRED)


func disconnect_tween() -> void:
	$Tween.disconnect("tween_all_completed", self, "_on_Tween_tween_all_completed")


func start_tween() -> void:
	$Tween.start()


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
		var next_dir : int = find_closest_direction(find_valid_directions())
		back_dir = (next_dir + 180) % 360
		add_rotation_task(next_dir)
		add_movement_task(next_dir)
	
	$Tween.start()
	pass


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


func find_closest_direction(valid_directions : PoolIntArray) -> int:
	var closest_direction : int = valid_directions[0]
	for i in valid_directions:
		var c_next_pos : Vector3 = next_pos(closest_direction)
		var i_next_pos : Vector3 = next_pos(i)
		if round(i_next_pos.distance_squared_to(target_pos)) < round(c_next_pos.distance_squared_to(target_pos)):
			closest_direction = i
	return closest_direction


func next_pos(dir : int, steps : int = 2) -> Vector3:
	return transform.origin + (Vector3.BACK.rotated(Vector3.UP, deg2rad(dir)) * steps)



