extends Node


var high_score : int = 0
var level : int = 1
var score : int = 0
var ghost_combo : int = 0

onready var ui : CanvasLayer = $UI
onready var hud : CanvasLayer = $HUD

var is_playing : bool = false


func _ready() -> void:
	high_score = SaveLoad.load_score()
	$HUD/high_score.text = String(high_score)


func _input(event : InputEvent) -> void:
	if event.is_action_pressed("start"):
		if not is_playing:
			$Show.play()
			is_playing = true
	elif event.is_action_pressed("ui_cancel"):
		stop()
	pass


func _exit_tree() -> void:
	ui.queue_free()
	hud.queue_free()


func _on_Player_ate_cookie() -> void:
	add_to_score(10)
	pass


func _on_Player_ate_power_pellet() -> void:
	add_to_score(50)
	$GhostsManager.go_frightened()
	ghost_combo = 0
	pass


func _on_Player_ate_a_ghost() -> void:
	add_to_score(200 * int(pow(2, ghost_combo)))
	ghost_combo += 1
	pass


func _on_Player_caught_by_a_ghost() -> void:
	pass


func camera_is_set() -> void:
	$Player.start()
	$GhostsManager.start_game()
	pass


func add_to_score(value : int) -> void:
	score += value
	$HUD/score.text = String(score)
	if score > high_score:
		high_score = score
		SaveLoad.save_score(high_score)
		$HUD/high_score.text = String(high_score)
	pass


func stop() -> void:
	$Player.stop()
	$GhostsManager.stop()
	is_playing = false
	$Show.play_to_show()
