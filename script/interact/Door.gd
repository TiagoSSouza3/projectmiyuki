extends Node2D
class_name door

func _ready():
	SignalManager.open_door_tutorial.connect(open_door)
	$Sprite.set_region_rect(Rect2(96, 96, 32, 16))
	$Area.collision_layer = 0x000d
	
func open_door() -> void:
	$Sprite.set_region_rect(Rect2(112, 64, 32, 16))
	$Area.collision_layer = 0x0000
