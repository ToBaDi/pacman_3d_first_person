extends Node


var level : int = 1
var score : int = 0

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


func _on_Player_eat_cookie():
	score += 10
	$HUD/score.text = String(score)
	pass






