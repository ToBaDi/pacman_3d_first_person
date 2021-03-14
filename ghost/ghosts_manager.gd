extends Node


onready var oikake : Ghost = $Oikake
onready var machibuse : Ghost = $Machibuse
onready var kimagure : Ghost = $Kimagure
onready var otoboke : Ghost = $Otoboke

var player_pos : Vector3 = Vector3.ZERO
var player_dir : int = 180
var oikake_pos : Vector3 = oikake.transform.origin


func _ready() -> void:
	oikake.start_game.set_instance(OikakePattern)
	oikake.enter_house.set_instance(OikakePattern)
	oikake.exit_house.set_instance(OikakePattern)
	
	machibuse.start_game.set_instance(MachibusePattern)
	machibuse.enter_house.set_instance(MachibusePattern)
	machibuse.exit_house.set_instance(MachibusePattern)
	
	kimagure.start_game.set_instance(KimagurePattern)
	kimagure.enter_house.set_instance(KimagurePattern)
	kimagure.exit_house.set_instance(KimagurePattern)
	
	otoboke.start_game.set_instance(OtobokePattern)
	otoboke.enter_house.set_instance(OtobokePattern)
	otoboke.exit_house.set_instance(OtobokePattern)
	
	for c in get_children():
		if c is Ghost:
			c.add_rotation_task(90)
			c.start_tween()
	
	pass


func _unhandled_key_input(event : InputEventKey) -> void:
	if event.is_action_pressed("ui_accept"):
		start_game()
	pass


func _on_Player_next_dir(dir : int) -> void:
	player_dir = dir


func _on_Player_next_pos(pos : Vector3) -> void:
	player_pos = pos


func _on_Oikake_next_pos(pos : Vector3) -> void:
	oikake_pos = pos


func start_game() -> void:
	for c in get_children():
		if c is Ghost:
			c.start_game.call_func(c)
			c.back_dir = 0
	pass
