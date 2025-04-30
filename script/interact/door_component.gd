extends Area2D
class_name TransComponent

var _player_ref: Character = null
var transition: Node = null

func _ready():
	transition = get_node("/root/Transition")

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer = null

func _on_body_entered(_body) -> void:
	if _body is Character:
		_player_ref = _body
		_animation.play("open")
		transition.fade_in(Callable(self, "trocar_de_cena"))
		await get_tree().create_timer(0.5).timeout
		_player_ref.global_position = _teleport_position
		Transition.fade_out()
