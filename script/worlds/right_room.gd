extends Node2D
class_name RightRoom

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	Transition.fade_out()
	zoom()
		
func zoom():
	camera.zoom.x = 1.4
	camera.zoom.y = 1.4
	camZoom = camera.zoom.x && camera.zoom.y
	pass
