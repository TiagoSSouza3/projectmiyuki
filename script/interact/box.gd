extends Node2D
class_name Box

const TILE_SIZE = 32
var direction = ""

func _ready():
	global_position == Vector2(106, 52.5)

func _process(_delta):
	if (direction != ""):
		match direction:
			"left":
				if Input.is_action_just_pressed("ui_left"):
					set_global_position(Vector2(global_position.x - TILE_SIZE, global_position.y))
					
			"right":
				if Input.is_action_just_pressed("ui_right"):
					set_global_position(Vector2(global_position.x + TILE_SIZE, global_position.y))
					
			"up":
				if Input.is_action_just_pressed("ui_up"):
					set_global_position(Vector2(global_position.x, global_position.y - TILE_SIZE))
					
			"down":
				if Input.is_action_just_pressed("ui_down"):
					set_global_position(Vector2(global_position.x, global_position.y + TILE_SIZE))

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
	
