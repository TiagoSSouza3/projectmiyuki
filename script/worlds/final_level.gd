extends Node2D

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

func _ready() -> void:
	Transition.fade_out()
	zoom()
	#player.follow_camera(camera)
		
func zoom():
	camera.zoom.x = 1.1
	camera.zoom.y = 1.1
	camZoom = camera.zoom.x && camera.zoom.y
	pass
