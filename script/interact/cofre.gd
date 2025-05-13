extends Area2D

@export var password_display: PackedScene
var player_near = false
var ui_instance

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		if password_display:
			ui_instance = password_display.instantiate()
			get_node("/root/BottomRoom/CanvasLayer").add_child(ui_instance)
			get_tree().paused = true
			print("UI instanciada:", ui_instance)

func _on_body_entered(body):
	if body.name == "character":
		player_near = true

func _on_body_exited(body):
	if body.name == "character":
		player_near = false
