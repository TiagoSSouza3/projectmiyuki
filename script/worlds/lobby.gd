extends Node2D

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera
@onready var label: Label = $Label

var camZoom: int

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	zoom()
	label.visible = true
	Transition.fade_out()

	var character = get_node("character")
	var spawn_points = get_node("SpawnPoints")

	if GameState.next_spawn_point_door != "" and spawn_points.has_node(GameState.next_spawn_point_door):
		var target_position = spawn_points.get_node(GameState.next_spawn_point_door).get_node(GameState.next_spawn_point).global_position
		player.global_position = target_position


func zoom():
	camera.zoom.x = 1
	camera.zoom.y = 1
	camZoom = camera.zoom.x && camera.zoom.y
	pass
