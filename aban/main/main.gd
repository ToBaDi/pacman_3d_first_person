extends Node


var level : int = 1

onready var ui : CanvasLayer = $UI
onready var hud : CanvasLayer = $HUD


func _exit_tree() -> void:
	ui.queue_free()
	hud.queue_free()
