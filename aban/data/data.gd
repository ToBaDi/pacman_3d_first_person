class_name Data
extends Node


var is_on_show : bool = false
var is_on_play_initiation : bool = false

onready var ground : MeshInstance = $"../Scene/Map/Ground"
onready var player_camera : Camera = $"../Scene/PlayerCamera"
onready var show_node : Spatial = $"../Scene/Show"
onready var show_camera : Camera = $"../Scene/Show/ShowCamera"
onready var animation_player : AnimationPlayer = $"../Scene/AnimationPlayer"
onready var world_environment : WorldEnvironment = $"../Scene/WorldEnvironment"

