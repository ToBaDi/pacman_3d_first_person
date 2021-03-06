class_name Ghost
extends Area


export(Material) var material : Material
export(Material) var frightened_material : Material
export(Material) var frightened_white_material : Material
export(Vector3) var scatter_taregt : Vector3 = Vector3.ZERO

var target : FuncRef
var teleport : Vector3 = Vector3.ZERO

var perv_pos : Vector3
var next_pos : Vector3
var perv_basis : Basis
var next_basis : Basis

onready var raycast : RayCast = $RayCast as RayCast


func _ready() -> void:
	$Body/Body.material_override = material
	$LeftMirror/Body.material_override = material
	$RightMirror/Body.material_override = material


func move(time : float) -> void:
	transform.origin = perv_pos.linear_interpolate(next_pos, time)


func smooth_rotation(time : float) -> void:
	$Body.transform.basis = perv_basis.slerp(next_basis, time)
	$LeftMirror.transform.basis = perv_basis.slerp(next_basis, time)
	$RightMirror.transform.basis = perv_basis.slerp(next_basis, time)



#const MOVEMENT_DURATION : float = .5
#const ROTATION_DURATION : float = .25
#const FRONT_HOUSE_POS : Vector3 = Vector3(24, 0, 0)
#
#export(Vector3) var scatter_pos : Vector3
#
#var target_pos : Vector3
#var back_dir : float = 180
#var teleport : Vector3 = Vector3.ZERO
#var rot : int = 0
#var rot_t : float = 1
#var rot_quat : Quat = Quat.IDENTITY
#var dont_go_up : bool = false
#var is_in_house : bool = true
#var is_frightened : bool = false
#var is_eaten : bool = false
#var start_game : FuncRef = FuncRef.new()
#var enter_house : FuncRef = FuncRef.new()
#var exit_house : FuncRef = FuncRef.new()
#var tween_msg_bus : Array = []
#var init_trans : Transform
#
#
#func _enter_tree() -> void:
#	target_pos = scatter_pos
#	init_trans = transform
#
#
#func _process(_delta : float) -> void:
#	var b : Quat = Quat.IDENTITY
#	b.set_euler(Vector3(deg2rad(90), deg2rad(rot), 0))
#	rot_quat = rot_quat.slerp(b, rot_t)
#	$Body.transform.basis = Basis(rot_quat)
#	$LeftMirror.transform.basis = Basis(rot_quat)
#	$RightMirror.transform.basis = Basis(rot_quat)
