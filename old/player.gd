extends Area


signal ate_cookie()
signal ate_power_pellet()
signal ate_a_ghost()
signal caught_by_a_ghost()
signal next_pos(pos)
signal next_dir(dir)


const MOVEMENT_DURATION : float = .5
const ROTATION_DURATION : float = .25

var clear : bool = true
var teleport : Vector3 = Vector3.ZERO
var init_trans : Transform


func _enter_tree() -> void:
	init_trans = transform


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left", true):
		rotate_left()
	elif event.is_action_pressed("right", true):
		rotate_right()
	elif event.is_action_pressed("back", true):
		rotate_back()
	pass


func _on_Tween_tween_all_completed() -> void:
	if teleport:
		transform.origin = teleport
		teleport = Vector3.ZERO
	$RayCast.cast_to = Vector3.FORWARD * 3
	$RayCast.force_raycast_update()
	if not $RayCast.get_collider():
		add_movement_task()
	$Tween.start()
	clear = true
	pass


func _on_Player_area_entered(area : Area) -> void:
	if area.is_in_group("Dots"):
		area.queue_free()
		emit_signal("ate_cookie")
	elif area.is_in_group("PowerDots"):
		area.queue_free()
		emit_signal("ate_power_pellet")
	elif area is Ghost:
		if (area as Ghost).is_frightened:
			(area as Ghost).go_eaten()
			emit_signal("ate_a_ghost")
		if (area as Ghost).is_eaten:
			pass
		else:
			emit_signal("caught_by_a_ghost")
	pass


func rotate_left() -> void:
	if clear:
		$RayCast.cast_to = Vector3.LEFT * 3
		$RayCast.force_raycast_update()
		if not $RayCast.get_collider():
			add_rotation_task(90)


func rotate_right() -> void:
	if clear:
		$RayCast.cast_to = Vector3.RIGHT * 3
		$RayCast.force_raycast_update()
		if not $RayCast.get_collider():
			add_rotation_task(-90)


func rotate_back() -> void:
	if clear:
		var r : int = RNG.rng.randi_range(0, 1)
		if r:
			add_rotation_task(180)
		else:
			add_rotation_task(-180)


func start() -> void:
	if not $Tween.is_active():
		var target : Vector3  = transform.origin + (transform.basis.z * 3)
		$Tween.interpolate_property(self, "translation",
		null, target, MOVEMENT_DURATION,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
		$Tween.start()


func add_rotation_task(value : int) -> void:
	var target : Vector3  = rotation_degrees + (Vector3.UP * value)
	$Tween.interpolate_property(self, "rotation_degrees",
		null, target, ROTATION_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	clear = false
	emit_signal("next_dir", (int(round(rotation_degrees.y)) + value) % 360)
	pass


func add_movement_task():
	var target : Vector3  = transform.origin + (transform.basis.z * 2)
	$Tween.interpolate_property(self, "translation",
		null, target, MOVEMENT_DURATION,
		Tween.TRANS_LINEAR, Tween.EASE_OUT)
	emit_signal("next_pos", target)
	pass


func stop() -> void:
	$Tween.stop_all()
	clear = true
	pass


