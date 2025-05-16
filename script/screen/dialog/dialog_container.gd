extends Control

signal dialogue_finished

@onready var Text = $Background/Text
@onready var bg = $Background

var is_showing = false

func show_text(text: String):
	visible = true
	$Background.visible = true
	$Background/Text.visible = true
	Text.text = text
	is_showing = true

func _unhandled_input(event):
	if is_showing and event.is_action_pressed("ui_cancel"):
		is_showing = false
		visible = false
		emit_signal("dialogue_finished")
