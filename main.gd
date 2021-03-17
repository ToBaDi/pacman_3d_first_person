extends Node


var level : int = 1
var score : int = 0
var ghost_combo : int = 0

onready var ui : CanvasLayer = $UI
onready var hud : CanvasLayer = $HUD

var is_playing : bool = false


func _ready() -> void:
	$Show.show()


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("start"):
		if not is_playing:
			$Show.play()
			is_playing = true
	pass


func _exit_tree() -> void:
	ui.queue_free()
	hud.queue_free()


func _on_Player_ate_cookie() -> void:
	score += 10
	$HUD/score.text = String(score)
	pass


func _on_Player_ate_power_pellet() -> void:
	score += 50
	$HUD/score.text = String(score)
	$GhostsManager.go_frightened()
	ghost_combo = 0
	pass


func _on_Player_ate_a_ghost() -> void:
	score += 200 * int(pow(2, ghost_combo))
	$HUD/score.text = String(score)
	ghost_combo += 1
	pass


func _on_Player_caught_by_a_ghost() -> void:
	pass


func camera_is_set() -> void:
	$Player.start()
	$GhostsManager.start_game()
	pass
