extends Area


export(Material) var material : Material


func _ready() -> void:
	if material:
		$Body.material_override = material


func _on_Tween_tween_all_completed():
	pass

