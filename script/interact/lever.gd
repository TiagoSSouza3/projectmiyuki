extends Node2D

@export var lever_id: int = 1
@export var linked_levers: Array[String] = []

@onready var animation: AnimationPlayer = $Animation
@onready var area: Area2D = $AreaActivator

var is_on := false
var can_interact := false

const LEVER_LINKS = {
	1: [2, 4],
	2: [1, 5],
	3: [2, 6],
	4: [1, 5],
	5: [2, 4, 6],
	6: [3, 5]
}

func _ready():
	if lever_id in [2, 3, 6]:
		is_on = true
	update_visual()
	
	add_to_group("levers")
	$AreaActivator.body_entered.connect(_on_body_entered)
	$AreaActivator.body_exited.connect(_on_body_exited)
	
	
func _process(delta: float) -> void:
	pass

func toggle():
	is_on = !is_on
	update_visual()
	
	if lever_id in LEVER_LINKS:
		for linked_id in LEVER_LINKS[lever_id]:
			var linked_lever = find_lever_by_id(linked_id)
			if linked_lever and linked_lever != self:
				linked_lever.is_on = is_on
				linked_lever.update_visual()

func find_lever_by_id(id: int) -> Node:
	var levers = get_tree().get_nodes_in_group("levers")
	for lever in levers:
		if lever.lever_id == id:
			return lever
	return null


func update_visual():
	var target_anim = "left" if is_on else "right"
	if $Animation.current_animation != target_anim:
		$Animation.play(target_anim)
	

func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		toggle()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		can_interact = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("character"):
		can_interact = false
