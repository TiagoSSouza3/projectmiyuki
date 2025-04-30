extends Node2D
class_name Chest

@export var chest_ui_scene : PackedScene

var is_open = false
var ui_instance

func interact():
	if not is_open:
		is_open = true
		print("Abrindo o inventário do baú...")

		if chest_ui_scene:
			ui_instance = chest_ui_scene.instantiate()
			get_tree().current_scene.add_child(ui_instance)
