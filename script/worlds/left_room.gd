extends Node2D

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera
@onready var label: Label = $Label

var camZoom: int

@export_category("Objects")
@export var _hud: CanvasLayer = null

func _ready() -> void:
	Transition.fade_out()
	zoom()
	label.visible = true
		
func zoom():
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
	camZoom = camera.zoom.x && camera.zoom.y
	pass
