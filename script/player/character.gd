extends CharacterBody2D
class_name Character

const TILE_SIZE = 32

@export var move_speed = 100

@onready var animation: AnimationPlayer = $animation
@onready var sprite: Sprite2D = $sprite
@onready var remote_transform: RemoteTransform2D = $remote_transform
@onready var timer: Timer = $Timer
@onready var collision: CollisionShape2D = $collision


var health : int = 3
var can_die : bool = false
var can_track: bool = true
var attacking: bool = false
var is_dead: bool = false
var normal_attack: bool = false
var dead: bool = false
var on_hit: bool = false
var nearby_interactable = null
var move_dir = Vector2.ZERO
var moving = false
var move_target = Vector2.ZERO
var last_dir := Vector2.DOWN
var camZoom = Vector2.ZERO

func _ready() -> void:
	add_to_group("character")
	$animation.play("idle")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and nearby_interactable:
		if nearby_interactable.has_method("interact"):
			nearby_interactable.interact()
	
	if is_dead:
		return
		
		
func _physics_process(delta: float) -> void:
	animate()

	if not moving:
		get_input()

		if move_dir != Vector2.ZERO:
			var motion = move_dir * TILE_SIZE

			if not is_collision_in_direction(motion):
				move_target = global_position + motion
				moving = true

	else:
		var distance = move_target - global_position
		var step = move_dir * move_speed * delta

		if step.length() >= distance.length():
			global_position = move_target
			moving = false
		else:
			global_position += step


func get_input():
	if Input.is_action_pressed("ui_up"):
		move_dir = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		move_dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		move_dir = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		move_dir = Vector2.RIGHT
	else:
		move_dir = Vector2.ZERO

func is_collision_in_direction(offset: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state

	var shape = collision.shape
	var transform = Transform2D(0, global_position)
	transform.origin += offset

	var query = PhysicsShapeQueryParameters2D.new()
	query.set_collide_with_areas(true)
	query.shape = shape
	query.transform = transform
	query.collision_mask = 0x000d

	var result = space_state.intersect_shape(query)
	return result.size() > 0


func animate():
	if moving:
		last_dir = move_dir

		if move_dir == Vector2.LEFT:
			sprite.flip_h = true
			if animation.current_animation != "left":
				animation.play("esquerda")
		elif move_dir == Vector2.RIGHT:
			sprite.flip_h = false
			if animation.current_animation != "right":
				animation.play("direita")
		elif move_dir == Vector2.DOWN:
			sprite.flip_h = false
			if animation.current_animation != "down":
				animation.play("frente")
		elif move_dir == Vector2.UP:
			if animation.current_animation != "up":
				animation.play("costas")
	else:
		if animation.current_animation != "idle":
			await get_tree().create_timer(0.4).timeout
			animation.play("idle")
		
func follow_camera(camera):
	var camera_path = camera.get_path()
	$remote_transform.remote_path = camera_path
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

func kill() -> void:
	can_die = true

func _on_animation_finished(anim_name) -> void:
	if anim_name == "dead":
		var _reaload: bool = get_tree().reaload_current_scene()

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("interact"):
		nearby_interactable = area

func _on_area_exited(area: Area2D) -> void:
	if area == nearby_interactable:
		nearby_interactable = null
		
func take_damage(amount):
	health -= amount
	print("Tomei dano! Vida atual:", health)
	animation.play("hurt")
	
	if health <= 0:
		queue_free()
