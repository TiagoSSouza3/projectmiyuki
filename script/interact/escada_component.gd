extends Area2D
class_name EscadaComponent

var _player_ref: Character = null
var transition: Node = null
var can_teleport := false

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer = null

func _ready():
	transition = get_node("/root/Transition")

func _process(_delta):
	if can_teleport and Input.is_action_just_pressed("interact"):
		_animation.play("open")
		transition.fade_in(Callable(self, "trocar_de_cena"))

func _on_body_entered(body: Node) -> void:
	if body is Character:
		_player_ref = body
		can_teleport = true

func _on_body_exited(body: Node) -> void:
	if body == _player_ref:
		can_teleport = false

func trocar_de_cena():
	await get_tree().create_timer(0.5).timeout
	_player_ref.global_position = _teleport_position
	Transition.fade_out()
