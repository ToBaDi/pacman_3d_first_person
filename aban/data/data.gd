class_name Data
extends Node


signal play_initiation_finished


var space_state : PhysicsDirectSpaceState
var is_on_show : bool = false
var is_on_play_initiation : bool = false

onready var ground : MeshInstance = $"../Scene/Map/Ground"
onready var player_camera : Camera = $"../Scene/PlayerCamera"
onready var show_node : Spatial = $"../Scene/Show"
onready var show_camera : Camera = $"../Scene/Show/ShowCamera"
onready var animation_player : AnimationPlayer = $"../Scene/AnimationPlayer"
onready var world_environment : WorldEnvironment = $"../Scene/WorldEnvironment"


func _ready() -> void:
	set_space_state()


func _physics_process(_delta : float) -> void:
	call_deferred("set_space_state")


func set_space_state() -> void:
	space_state = PhysicsServer.space_get_direct_state(get_tree().root.world.space)
