extends Control

func _ready() -> void:
	var transition = get_node("/root/Transition")
	transition.fade_out()
	$Animation.play("bg_move")
	$Animation.play("character")
	
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/worlds/tutorial.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/ScreenResource/credits.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
