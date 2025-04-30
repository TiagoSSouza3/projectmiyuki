extends CharacterBody2D

@onready var texture: AnimatedSprite2D = $texture
@onready var attack_collision: CollisionShape2D = $AttackArea/attack_collision

const LIFE_MAX = 10
const HIT = 1

var attacking: bool = false
var speed : int = 100
var player_chase : bool = false
var player = null
var movement
var life: int = LIFE_MAX
var is_dead: bool = false
var take_hit: bool = false

func _ready() -> void:
	pass
	

func _physics_process(_delta: float) -> void:
	if is_dead or take_hit:
		return
	if player_chase:
		position += (player.position - position) / speed
		#texture.play("walk")
		
	movement_idle()
	
	move_and_slide()
	

func movement_idle() -> void:
	pass
	

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
	

func _on_detection_area_shape_exited(_body: Node2D) -> void:
	player = null
	player_chase = false
	#animation.play("walk")
	

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		attacking = true
		#animation.play("attack")
		body.take_damage(HIT)
	


func _on_attack_area_body_exited(body: Node2D) -> void:
		if body.is_in_group("character"):
			attacking = false
			#animation.play("walk")
	

#func _on_animation_finished(anim_name):
#	if is_dead:
#		queue_free()
#		return
#	if anim_name == "attack":
#		if attacking:
#			animation.play("attack")
#		else:
#			animation.play("walk")
#	elif anim_name == "hit":
#		taking_hit = false
#		if attacking:
#			animation.play("attack")
#		else:
#			animation.play("walk")

func take_damage(amount: int):
	if is_dead:
		return
	life -= amount
	if life <= 0:
		die()
#	else:
#		taking_hit = true
#		animation.play("hit")
		
func die():
	is_dead = true
#	animation.play("death")
	velocity = Vector2.ZERO
