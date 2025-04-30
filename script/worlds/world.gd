extends Node2D
class_name world

@onready var player: CharacterBody2D = $character
@onready var camera: Camera2D = $camera

var camZoom: int

const _DIALOG_SCREEN: PackedScene = preload("res://scene/ScreenResource/dialog_screen.tscn")

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
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = _dialog_data
		_hud.add_child(_new_dialog)
		
func zoom():
	camera.zoom.x = 1.5
	camera.zoom.y = 1.5
	camZoom = camera.zoom.x && camera.zoom.y
	pass
