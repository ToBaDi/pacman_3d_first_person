class_name Data
extends Node


const SCATTER : bool = false
const CHASE : bool = true


# warning-ignore:unused_signal
signal on_play

var is_on_show : bool = false
var is_on_play : bool = false

var score : int = 0

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
var ghost_state : bool = SCATTER
onready var ghosts : Array = [
	$"../Scene/Oikake" as Ghost,
	$"../Scene/Machibuse" as Ghost,
	$"../Scene/Kimagure" as Ghost,
	$"../Scene/Otoboke" as Ghost,
]
var ghosts_dir : PoolIntArray = [0, 0, 0, 0]
var ghosts_targets : PoolVector3Array = [Vector3.ZERO, Vector3.ZERO, Vector3.ZERO, Vector3.ZERO]
var ghosts_tweens : Array = [Tween.new(), Tween.new(), Tween.new(), Tween.new()]
#        ]
