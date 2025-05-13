extends Node2D
class_name Chest

#var ui_instance

#func interact():
#	if not is_open:
#		is_open = true
#		print("Abrindo o inventário do baú...")
#		if chest_ui_scene:
#			ui_instance = chest_ui_scene.instantiate()
#			get_tree().current_scene.add_child(ui_instance)


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if SignalManager.open_door_tutorial:
		SignalManager.all_buttons_pressed.connect(open_chest)
		SignalManager.open_safe.connect(open_chest)
	#else:
	#	SignalManager.all_buttons_pressed.connect(close_chest)
	#	$Texture/Animation.play("RESET")
	
func open_chest():
	$Texture/Animation.play("open")
	$Key.visible = true
	$Key/AnimatedSprite2D.play("key")
	
func close_chest():
	$Texture/Animation.play("RESET")
