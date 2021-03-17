extends Spatial


func show() -> void:
	$Camera.current = true
	$AnimationPlayer.play("Show")


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
	pass
