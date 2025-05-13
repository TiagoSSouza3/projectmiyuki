extends Node2D

@export var lever1: Node2D
@export var lever2: Node2D
@export var lever3: Node2D
@export var lever4: Node2D
@export var lever5: Node2D
@export var lever6: Node2D

const LEVER_LINKS = {
	1: [2, 4],
	2: [1, 5],
	3: [2, 6],
	4: [1, 5],
	5: [2, 4, 6],
	6: [3, 5]
}

var is_on := true
var can_interact := true

func _ready():
	for lever in [lever1, lever2, lever3, lever4, lever5, lever6]:
		lever.set_inicial()
		update_visual(lever)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		for lever in [lever1, lever2, lever3, lever4, lever5, lever6]:
			if lever.can_interact:
				toggle(lever)

func toggle(lever):
	lever.is_on = !lever.is_on
	update_visual(lever)
	
	if lever.lever_id in LEVER_LINKS:
		for linked_id in LEVER_LINKS[lever.lever_id]:
			var linked_lever = find_lever_by_id(linked_id)
			if linked_lever and linked_lever != self:
				linked_lever.is_on = !linked_lever.is_on
				update_visual(linked_lever)

func find_lever_by_id(id: int) -> Node:
	var levers = get_tree().get_nodes_in_group("levers")
	for lever in levers:
		if lever.get_id() == id:
			return lever
	return null

func update_visual(lever):
	var target_anim = "right" if lever.is_on else "left"
	if lever.side != target_anim:
		lever.update_side()
		lever.animate(target_anim)
	
