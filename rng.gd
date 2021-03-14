extends Node


var rng : RandomNumberGenerator = RandomNumberGenerator.new()


func _enter_tree() -> void:
	rng.randomize()

