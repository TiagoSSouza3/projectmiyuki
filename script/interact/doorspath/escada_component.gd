extends Area2D
class_name EscadaComponent

var _player_ref: Character = null
var transition: Node = null
var can_teleport := false

@onready var transition_node = get_parent().get_node("TransitionScene")

func _ready():
	transition = get_node("/root/Transition")

func _process(_delta):
	if can_teleport and Input.is_action_just_pressed("interact"):
		Transition.fade_in()

func _on_body_entered(body: Node) -> void:
	if body is Character:
		_player_ref = body
		can_teleport = true
	if transition_node:
		transition_node.transition_scene.emit()
	else:
		push_error("TransitionScene não encontrado!")

func _on_body_exited(body: Node) -> void:
	if body == _player_ref:
		can_teleport = false
