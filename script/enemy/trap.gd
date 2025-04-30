extends Node2D
class_name Trap

@onready var area = $DamageArea
@onready var anim = $Animation

func _ready():
	area.body_entered.connect(_on_body_entered)
	start_cycle()
	
func start_cycle():
	await get_tree().create_timer(2.0).timeout
	anim.play("spike_up")
	start_cycle()
	
func _on_body_entered(body: Node2D) -> void:
	if anim.is_playing() and anim.current_animation == "spike_up":
		if body.has_method("take_damage"):
			body.take_damage(1)
