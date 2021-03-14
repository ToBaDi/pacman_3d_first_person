extends Node


onready var oikake : Ghost = $Oikake
onready var machibuse : Ghost = $Machibuse
onready var kimagure : Ghost = $Kimagure
onready var otoboke : Ghost = $Otoboke


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
			c.start_game.call_func(c)
#			c.connect_tween()
#			c.start_play()
	
	pass






