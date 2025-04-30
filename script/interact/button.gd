extends Node2D
class_name ButtonTutorial

func area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.name == "BoxCollisionArea":
		SignalManager.open_door_tutorial.emit()
