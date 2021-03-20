class_name SaveLoad
extends Object


static func save_score(score : int) -> void:
	var file := File.new()
	var err : int = file.open("user://save", File.WRITE)
	if err == OK:
		file.store_64(score)
	file.close()


static func load_score() -> int:
	var score : int = 0
	var file := File.new()
	var err : int = file.open("user://save", File.READ)
	if err == OK:
		score = file.get_64()
	file.close()
	return score

