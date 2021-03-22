extends Spatial


func _ready() -> void:
	$SkyAnimation.play("day")
	$AnimationPlayer.play("Norm")


func show() -> void:
	$Camera.current = true
	$AnimationPlayer.play("Show")


func play_to_show() -> void:
	$Camera.global_transform = $"../Player/PlayerCamera".global_transform
	transform.basis = Transform.IDENTITY.basis
	$AnimationPlayer.play("play_to_show")
	pass


func play() -> void:
	$AnimationPlayer.play("Play")


func night() -> void:
	var pos : float = $AnimationPlayer.current_animation_position
	$AnimationPlayer.stop(false)
	$SkyAnimation.play("night")
	while $SkyAnimation.is_playing():
		yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("Play")
	$AnimationPlayer.seek(pos, false)


func day() -> void:
	var pos : float = $AnimationPlayer.current_animation_position
	$AnimationPlayer.stop(false)
	$SkyAnimation.play("day")
	while $SkyAnimation.is_playing():
		yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("play_to_show")
	$AnimationPlayer.seek(pos, false)
	pass
