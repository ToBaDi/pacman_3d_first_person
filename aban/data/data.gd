class_name Data
extends Node


var is_on_show : bool = false
var is_on_play : bool = false


var rng : RandomNumberGenerator = RandomNumberGenerator.new()

onready var ground : MeshInstance = $"../Scene/Map/Ground"
onready var show_node : Spatial = $"../Scene/Show"
onready var show_camera : Camera = $"../Scene/Show/ShowCamera"
onready var world_environment : WorldEnvironment = $"../Scene/WorldEnvironment"

# Player [
onready var player : Area = $"../Scene/Player"
onready var player_camera : Camera = $"../Scene/Player/Camera"
onready var player_raycast : RayCast = $"../Scene/Player/RayCast"
var player_dir : int = 0
#        ]

# Ghosts [
onready var static_ghosts : Array = [
	$"../Scene/Oikake",
	$"../Scene/Machibuse",
	$"../Scene/Kimagure",
	$"../Scene/Otoboke",
]
var frightened_ghosts : Array = []
var frightened_timer : PoolRealArray = [0.0, 0.0, 0.0, 0.0]
var eaten_ghosts : Array = []
#        ]
