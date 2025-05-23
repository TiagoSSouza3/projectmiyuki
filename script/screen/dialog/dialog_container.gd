extends Control

signal dialogue_finished

@onready var Text = $Background/Text
@onready var bg = $Background

var is_showing = false

func _ready() -> void:
	set_process_unhandled_input(true)
	process_mode = Node2D.PROCESS_MODE_WHEN_PAUSED

func show_text(text: String):
	visible = true
	$Background.visible = true
	$Background/Text.visible = true
	Text.text = text
	GameState.dialogue_active = true
	is_showing = true

func _unhandled_input(event):
	if is_showing and event.is_action_pressed("ui_cancel"):
		is_showing = false
		visible = false
		GameState.dialogue_active = false
		emit_signal("dialogue_finished")
