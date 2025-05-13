extends Control

signal finished

@onready var portrait: TextureRect = $Background/Portrait
@onready var text: RichTextLabel = $Background/Text
@onready var animation: AnimationPlayer = $Animation
@onready var timer: Timer = $Timer

@export var wait_timer: float = 0.02

var can_skip_dialog: bool = false
var dialog_size: int
var dialog_index: int = 0
var dialog_list: Dictionary = {
	"dialog": [
		"Olá querido esqueleto",
		"abacatudo"
	],
	"portrait": null
}

func _ready() -> void:
	$Animation.play("fade_in")
	show_dialog()
	dialog_size = dialog_list["dialog"].size()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_skip_dialog:
		can_skip_dialog = false
		show_dialog()
	
func show_dialog() -> void:
	if dialog_index == dialog_size:
		$Animation.play("fade_out")
		await $Animation.animation_finished
		emit_signal("finished")
		queue_free()
		return
		
	text.visible = 0
	text.text = dialog_list["dialog"][dialog_index]
	dialog_index += 1
	
	while text.visible_characters < len(text.text):
		text.visible_characters += 1
		timer.start(wait_timer)
		await get_tree().create_timer(0.02).timeout
		
	can_skip_dialog = true
