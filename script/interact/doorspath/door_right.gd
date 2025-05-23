extends Node2D
class_name DoorSRight

var _player_ref: Character = null
var transition: Node = null
var can_teleport := false

@onready var label: Label = $Label
@onready var transition_node = get_parent().get_node("DoorSideRight/TransitionScene")

func _ready():
	label.visible = false
	transition = get_node("/root/Transition")

func _process(_delta):
	if can_teleport and Input.is_action_just_pressed("interact"):
		if transition_node:
			transition_node.transition_scene.emit()
			Transition.fade_in()

func _on_body_entered(body: Node) -> void:
	if body is Character:
		label.visible = true
		_player_ref = body
		can_teleport = true

func _on_body_exited(body: Node) -> void:
	if body == _player_ref:
		label.visible = false
		can_teleport = false
