extends Node2D
class_name DoorLevel

const REQUIRED_KEYS := 3

var _player_ref: Character = null
var transition: Node = null
var can_teleport := false

@onready var transition_node = get_parent().get_node("DoorUp/TransitionScene")
@onready var character: CharacterBody2D = $Character

func _ready():
	transition = get_node("/root/Transition")

func _process(_delta):
	if can_teleport and Input.is_action_just_pressed("interact"):
		if GameState.key_count >= 3:
			if transition_node:
				transition_node.transition_scene.emit()
				Transition.fade_in()
		else:
			print("Você precisa de %d chaves para usar esta porta!" % REQUIRED_KEYS)
			

func _on_body_entered(body: Node) -> void:
	if body is Character:
		_player_ref = body
		can_teleport = true

func _on_body_exited(body: Node) -> void:
	if body == _player_ref:
		can_teleport = false
