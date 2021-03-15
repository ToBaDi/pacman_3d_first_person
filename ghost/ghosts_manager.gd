extends Node


onready var oikake : Ghost = $Oikake
onready var machibuse : Ghost = $Machibuse
onready var kimagure : Ghost = $Kimagure
onready var otoboke : Ghost = $Otoboke
onready var oikake_pos : Vector3 = oikake.transform.origin

var player_pos : Vector3 = Vector3.ZERO
var player_dir : int = 180


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


### Gathering information for target calculation
func _on_Player_next_dir(dir : int) -> void:
	player_dir = dir


func _on_Player_next_pos(pos : Vector3) -> void:
	player_pos = pos


func _on_Oikake_next_pos(pos : Vector3) -> void:
	oikake_pos = pos
###


### Targeting calculation
func _on_Oikake_tween_all_completed() -> void:
	oikake.target_pos = player_pos


func _on_Machibuse_tween_all_completed() -> void:
	if int(round(player_dir)) == 90 or int(round(player_dir)) == -270:
			machibuse.target_pos = player_pos + Vector3(8, 0, -8)
			return
	machibuse.target_pos = player_pos + (Vector3.BACK * 8).rotated(Vector3.UP, deg2rad(player_dir))
	pass


func _on_Kimagure_tween_all_completed() -> void:
	pass


func _on_Otoboke_tween_all_completed() -> void:
	pass
###


func start_game() -> void:
	for c in get_children():
		if c is Ghost:
			c.start_game.call_func(c)
			c.back_dir = 0
	pass
