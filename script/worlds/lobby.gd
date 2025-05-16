extends Node2D

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	Transition.fade_out()
	zoom()
	player.follow_camera(camera)
	
	var character = get_node("character")
	var spawn_points = get_node("SpawnPoints")

	if GameState.next_spawn_point != "" and spawn_points.has_node(GameState.next_spawn_point):
		var target_position = spawn_points.get_node(GameState.next_spawn_point).global_position
		player.global_position = target_position
		

func zoom():
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
	camZoom = camera.zoom.x && camera.zoom.y
	pass
