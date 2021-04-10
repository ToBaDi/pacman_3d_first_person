class_name Data
extends Node


var is_on_show : bool = false
var is_on_play : bool = false

var player_dir : int = 0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var ground : MeshInstance = $"../Scene/Map/Ground"
onready var player : KinematicBody = $"../Scene/Player"
onready var player_camera : Camera = $"../Scene/Player/Camera"
onready var player_raycast : RayCast = $"../Scene/Player/RayCast"
onready var show_node : Spatial = $"../Scene/Show"
onready var show_camera : Camera = $"../Scene/Show/ShowCamera"
onready var animation_player : AnimationPlayer = $"../Scene/AnimationPlayer"
onready var world_environment : WorldEnvironment = $"../Scene/WorldEnvironment"

