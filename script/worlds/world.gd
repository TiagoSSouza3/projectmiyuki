extends Node2D
class_name world

@onready var label: Label = $Label
@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

func _ready() -> void:
	Transition.fade_out()
	zoom()
	player.follow_camera(camera)
	if label.visible:
		await get_tree().create_timer(1.2).timeout
		label.visible = false
		
func zoom():
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
	camZoom = camera.zoom.x && camera.zoom.y
	pass
	
