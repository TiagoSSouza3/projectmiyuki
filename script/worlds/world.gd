extends Node2D
class_name world

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

var _dialog_data : Dictionary = { #USAR EM CADA UM DOS NPC'S UMA DIFERENTE, NÃO AONDE ESTOU COLOCANDO AGORA
	0: {
		"faceset": "",
		"dialog": "que dia feliz",
		"title": "Raul"
	}
}

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	zoom()
	player.follow_camera(camera)
		
func zoom():
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
	camZoom = camera.zoom.x && camera.zoom.y
	pass
