extends Spatial


func show() -> void:
	$Camera.current = true
	$AnimationPlayer.play("Show")


func play() -> void:
	$AnimationPlayer.play("Play")
