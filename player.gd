extends Area


const MOVEMENT_DURATION : float = .5
const ROTATION_DURATION : float = .25

var clear : bool = true
var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
	pass


func _physics_process(_delta : float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left", true):
		rotate_left()
	if event.is_action_pressed("ui_right", true):
		rotate_right()
	if event.is_action_pressed("ui_down", true):
		rotate_back()
	if event.is_action_pressed("ui_accept", true):
		start()
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
		var r : int = rng.randi_range(0, 1)
		if r:
			add_rotation_task(180)
		else:
			add_rotation_task(-180)

func start() -> void:
		if not $Tween.is_active():
			var target : Vector3  = transform.origin + (-transform.basis.z * 3)
			$Tween.interpolate_property(self, "translation",
			null, target, MOVEMENT_DURATION,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
			$Tween.start()


func add_rotation_task(value : int) -> void:
	var target : Vector3  = rotation_degrees + (Vector3.UP * value)
	$Tween.interpolate_property(self, "rotation_degrees",
		null, target, ROTATION_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	clear = false
	pass


func add_movement_task():
	var target : Vector3  = transform.origin + (-transform.basis.z * 2)
	$Tween.interpolate_property(self, "translation",
		null, target, MOVEMENT_DURATION,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)
	pass


func _on_Tween_tween_all_completed():
	$RayCast.cast_to = Vector3.FORWARD * 3
	$RayCast.force_raycast_update()
	if not $RayCast.get_collider():
		add_movement_task()
	$Tween.start()
	clear = true
	pass