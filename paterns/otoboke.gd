class_name OtobokePattern
extends GhostPattern


static func _start_game(ghost : Ghost) -> void:
	ghost.start_tween()
	ghost.connect_tween()
	pass


static func _exit_house(_ghost : Ghost) -> void:
	pass


static func _enter_house(_ghost : Ghost) -> void:
	pass
