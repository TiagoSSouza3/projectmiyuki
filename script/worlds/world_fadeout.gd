extends Node2D
class_name WorldFadeout

@onready var label: Label = $Label
@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	zoom()
	label.visible = true
	Transition.fade_out()
		
func zoom():
	camera.zoom.x = 1.15
	camera.zoom.y = 1.15
	camZoom = camera.zoom.x && camera.zoom.y
	pass
