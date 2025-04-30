extends Control
class_name DialogScreen

var _step: float = 0.05

var _id: int
var data: Dictionary = {
	"Dialog": [
		"Que dia alegre, meus amigos",
		"Sanchos"
	],
	"portrait": null,
	"name": ""
}
var dialog_size: int
var dialog_index: int = 0

signal finished

@onready var animation: AnimationPlayer = $Animation
@onready var dialog_c: RichTextLabel = $Bg/HBoxContainer/VBoxContainer/Dialog

@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready() -> void:
	animation.play("appear")
	dialog_size = data["Dialog"].size()
	show_dialog()
	
func show_dialog() -> void:
	if dialog_index == dialog_size:
		animation.play("desappear")
		clamp(animation, 0, "animation_finished")
		emit_signal("finished")
		queue_free()
		return
	dialog_c.text = data["Dialog"][dialog_index]
	
	dialog_index += 1
	
	while dialog_c.visible_characters < len(dialog_c.text):
		dialog_c.visible_characters += 1 
		
func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept") and dialog_c.visible_ratio < 1:
		_step = 0.01
		return 
	_step = 0.05
	if Input.is_action_just_pressed("ui_accept"):
		_id += 1
		if _id == data.size():
			queue_free()
			return
