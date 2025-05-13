extends Node2D

@export var lever_id: int = 1

var is_on := false
var can_interact := false
var side = ""

func set_inicial():
	if lever_id in [2, 3, 6]:
		is_on = true
		side = "right"
	else:
		side = "left"
		
	animate(side)
		
	add_to_group("levers")
	
func update_side():
	side = "right" if is_on else "left"
	
func animate(anim_name):
	$Animation.play(anim_name)

func get_id():
	return lever_id

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		can_interact = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		can_interact = false
