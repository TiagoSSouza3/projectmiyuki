extends Node2D

signal open_door_tutorial
signal close_door_tutorial

var active_bodies := 0

func _ready():
	$Area.connect("area_shape_entered", Callable(self, "_on_area_entered"))
	$Area.connect("area_shape_exited", Callable(self, "_on_area_exited"))
	
func pressed():
	pass

func area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("activator"):
		active_bodies += 1
		if active_bodies == 1:
			$AnimationPlayer.play("press")
			SignalManager.open_door_tutorial.emit()

func area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("activator"):
		active_bodies -= 1
		if active_bodies <= 0:
			active_bodies = 0
			$AnimationPlayer.play("RESET")
			SignalManager.close_door_tutorial.emit()
