extends Node2D

func _ready():
	open_door()
	close_door()
	$Sprite.set_region_rect(Rect2(96, 96, 32, 16))
	$Area.collision_layer = 0x000d
	
func open_door() -> void:
	if SignalManager.all_buttons_pressed:
		SignalManager.open_door_tutorial.connect(open_door)
	$Sprite.set_region_rect(Rect2(112, 64, 32, 16))
	$Area.collision_layer = 0x0000
	
func close_door() -> void:
	SignalManager.close_door_tutorial.connect(close_door)
	$Sprite.set_region_rect(Rect2(96, 96, 32, 16))
	$Area.collision_layer = 0x000d
	
