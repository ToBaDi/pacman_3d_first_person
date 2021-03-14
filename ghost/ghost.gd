class_name Ghost
extends Area


enum {UP, LEFT, DOWN, RIGHT}

const MOVEMENT_DURATION : float = .5
const ROTATION_DURATION : float = .25

export(Material) var material : Material
export(Vector3) var scatter_pos : Vector3

var target_pos : Vector3
var back_dir : float = 180
var teleport : Vector3 = Vector3.ZERO
var rot : int = 0
var start_game : FuncRef = FuncRef.new()
var enter_house : FuncRef = FuncRef.new()
var exit_house : FuncRef = FuncRef.new()


func _init() -> void:
	start_game.set_function("_start_game")
	enter_house.set_function("_enter_house")
	exit_house.set_function("_exit_house")


func _enter_tree() -> void:
	target_pos = scatter_pos


func _ready() -> void:
	if material:
		$Body.material_override = material
		$LeftMirror.material_override = material
		$RightMirror.material_override = material


func _process(_delta : float) -> void:
	$Body.rotation_degrees.y = rot
	$LeftMirror.rotation_degrees.y = rot
	$RightMirror.rotation_degrees.y = rot


func connect_tween() -> void:
	if not $Tween.is_connected("tween_all_completed", self, "_on_Tween_tween_all_completed"):
# warning-ignore:return_value_discarded
		$Tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed", [], Tween.CONNECT_DEFERRED)


func disconnect_tween() -> void:
	$Tween.disconnect("tween_all_completed", self, "_on_Tween_tween_all_completed")


func start_tween() -> void:
	$Tween.start()


func start_play() -> void:
	_on_Tween_tween_all_completed()


func _on_Tween_tween_all_completed():
	if teleport:
		transform.origin = teleport
		teleport = Vector3.ZERO
	var next_dir : int = find_closest_direction(find_valid_directions())
	back_dir = (next_dir + 180) % 360
	add_rotation_task(next_dir)
	add_movement_task(next_dir)
	$Tween.start()
	pass


func add_rotation_task(dir : int) -> void:
	$Tween.interpolate_property(self, "rot",
		null, dir, ROTATION_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	pass


func add_movement_task(dir : int, steps : int = 2):
	var t : Vector3  = next_pos(dir, steps)
	$Tween.interpolate_property(self, "translation",
		null, t, MOVEMENT_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	pass


func find_valid_directions() -> PoolIntArray:
	var valid_directions : PoolIntArray = []
	for i in range(1,5):
		var dir : int = (90 * i) % 360
		if back_dir == dir:
			continue
		$RayCast.global_transform = Transform.IDENTITY
		$RayCast.global_transform.origin = transform.origin
		$RayCast.set_cast_to(Vector3.FORWARD.rotated(Vector3.UP, deg2rad(dir)) * 3)
		$RayCast.force_raycast_update()
		if not $RayCast.get_collider():
			valid_directions.append(dir)
	return valid_directions


func find_closest_direction(valid_directions : PoolIntArray) -> int:
	var closest_direction : int = valid_directions[0]
	for i in valid_directions:
		var c_next_pos : Vector3 = next_pos(closest_direction)
		var i_next_pos : Vector3 = next_pos(i)
		if i_next_pos.distance_squared_to(target_pos) < c_next_pos.distance_squared_to(target_pos):
			closest_direction = i
	return closest_direction


func next_pos(dir : int, steps : int = 2) -> Vector3:
	return transform.origin + (Vector3.FORWARD.rotated(Vector3.UP, deg2rad(dir)) * steps)



