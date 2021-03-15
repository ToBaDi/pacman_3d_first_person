extends Node


onready var oikake : Ghost = $Oikake
onready var machibuse : Ghost = $Machibuse
onready var kimagure : Ghost = $Kimagure
onready var otoboke : Ghost = $Otoboke
onready var oikake_pos : Vector3 = oikake.transform.origin

var player_pos : Vector3 = Vector3.ZERO
var player_dir : int = 180
var on_scatter : bool = false
var debug : bool = true


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
	
	$TargetingDebug/Oikake.material_override = oikake.material
	$TargetingDebug/Machibuse.material_override = machibuse.material
	$TargetingDebug/Kimagure.material_override = kimagure.material
	$TargetingDebug/Otoboke.material_override = otoboke.material
	
	pass


func _physics_process(_delta : float) -> void:
	if debug:
		$TargetingDebug/Oikake.transform.origin = Vector3(oikake.target_pos.x, 10, oikake.target_pos.z - .5)
		$TargetingDebug/Machibuse.transform.origin = Vector3(machibuse.target_pos.x + .5, 10, machibuse.target_pos.z)
		$TargetingDebug/Kimagure.transform.origin = Vector3(kimagure.target_pos.x - .5, 10, kimagure.target_pos.z)
		$TargetingDebug/Otoboke.transform.origin = Vector3(otoboke.target_pos.x, 10, otoboke.target_pos.z + .5)
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
	if oikake.is_in_house:
		return
	
	if on_scatter:
		oikake.target_pos = oikake.scatter_pos
		return
	
	oikake.target_pos = player_pos


func _on_Machibuse_tween_all_completed() -> void:
	if machibuse.is_in_house:
		return
	
	if on_scatter:
		machibuse.target_pos = machibuse.scatter_pos
		return
	
	if int(round(player_dir)) == 90 or int(round(player_dir)) == -270:
			machibuse.target_pos = player_pos + Vector3(8, 0, -8)
			return
	machibuse.target_pos = player_pos + (Vector3.BACK * 8).rotated(Vector3.UP, deg2rad(player_dir))


func _on_Kimagure_tween_all_completed() -> void:
	if kimagure.is_in_house:
		return
	
	if on_scatter:
		kimagure.target_pos = kimagure.scatter_pos
		return
	
	var int_tile : Vector3
	
	if int(round(player_dir)) == 90 or int(round(player_dir)) == -270:
		int_tile = player_pos + Vector3(4, 0, -4)
	else:
		int_tile = player_pos + (Vector3.BACK * 4).rotated(Vector3.UP, deg2rad(player_dir))
	
	kimagure.target_pos = int_tile + (oikake_pos - int_tile).rotated(Vector3.UP, deg2rad(180))


func _on_Otoboke_tween_all_completed() -> void:
	if otoboke.is_in_house:
		return
	
	if on_scatter:
		otoboke.target_pos = otoboke.scatter_pos
		return
	
	if int(round(abs(otoboke.transform.origin.distance_squared_to(player_pos)))) < pow(8 * 2, 2):
		otoboke.target_pos = otoboke.scatter_pos
	else:
		otoboke.target_pos = player_pos
###


func start_game() -> void:
	for c in get_children():
		if c is Ghost:
			c.start_game.call_func(c)
			c.back_dir = 0
	pass


func go_frightened() -> void:
	oikake.go_frightened()
	machibuse.go_frightened()
	kimagure.go_frightened()
	otoboke.go_frightened()
	pass




