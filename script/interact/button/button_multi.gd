extends Node2D

var active_bodies := 0
static var total_pressed_buttons := 0
static var total_buttons := 20

func _ready():
	$Area.connect("area_shape_entered", Callable(self, "_on_area_entered"))
	$Area.connect("area_shape_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("activator"):
		active_bodies += 1
		if active_bodies == 1:
			$AnimationPlayer.play("press")
			total_pressed_buttons += 1
			check_all_buttons()

func _on_area_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("activator"):
		active_bodies -= 1
		if active_bodies <= 0:
			active_bodies = 0
			$AnimationPlayer.play("RESET")
			total_pressed_buttons -= 1
			check_all_buttons()

func check_all_buttons():
	if total_pressed_buttons == total_buttons:
		SignalManager.all_buttons_pressed.emit()
	else:
		SignalManager.not_all_buttons_pressed.emit()
