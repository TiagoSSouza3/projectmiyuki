extends Node2D
class_name Box

const TILE_SIZE = 32
var direction = ""

func _ready() -> void:
	$BoxCollisionArea.add_to_group("activator")

func _process(_delta):
	if direction != "":
		var move_vector = Vector2.ZERO
			
		match direction:
			"left":
				if Input.is_action_just_pressed("ui_left"):
					move_vector = Vector2(-TILE_SIZE, 0)
			"right":
				if Input.is_action_just_pressed("ui_right"):
					move_vector = Vector2(TILE_SIZE, 0)
			"up":
				if Input.is_action_just_pressed("ui_up"):
					move_vector = Vector2(0, -TILE_SIZE)
			"down":
				if Input.is_action_just_pressed("ui_down"):
					move_vector = Vector2(0, TILE_SIZE)

		if move_vector != Vector2.ZERO and not is_colliding_at(global_position + move_vector):
			global_position += move_vector

func is_colliding_at(position: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var box_shape = $BoxCollisionArea/Collision.shape
	if box_shape == null:
		return false

	var transform = Transform2D(0, position)

	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = box_shape
	query.transform = transform
	query.exclude = [$BoxCollisionArea.get_rid()]
	query.collision_mask = 12

	var result = space_state.intersect_shape(query, 1)
	return result.size() > 0
	

func right_area_entered(_area):
	direction = "left"

func left_area_entered(_area):
	direction = "right"

func up_area_entered(_area):
	direction = "down"

func down_area_entered(_area):
	direction = "up"

func area_exited(_area):
	direction = ""
