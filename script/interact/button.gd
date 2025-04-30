extends Node2D
class_name ButtonTutorial

func area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "BoxCollisionArea":
		SignalManager.open_door_tutorial.emit()
