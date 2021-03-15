extends Node


var level : int = 1
var score : int = 0
var ghost_combo : int = 0

onready var ui : CanvasLayer = $UI
onready var hud : CanvasLayer = $HUD


#func _ready() -> void:
#	print($Dots.get_child_count())
#	for c in get_children():
#		if c == $HUD or c == $UI:
#			continue
#		(c as Node).queue_free()
#		remove_child(c)


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
