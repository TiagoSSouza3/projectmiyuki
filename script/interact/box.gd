extends Node2D
class_name Box

const TILE_SIZE = 32
var direction = ""


func _ready():
	for child in get_children():
		if child.has_method("connect_to_box"):
			child.connect_to_box(self)
	
func _process(_delta):
	match direction:
		"left":
			if Input.is_action_just_pressed("ui_left"):
				global_position.x =- TILE_SIZE
				
		"right":
			if Input.is_action_just_pressed("ui_right"):
				global_position.x =+ TILE_SIZE
				
		"up":
			if Input.is_action_just_pressed("ui_up"):
				global_position.y =- TILE_SIZE
				
		"down":
			if Input.is_action_just_pressed("ui_down"):
				global_position.y =+ TILE_SIZE

func right_area_entered(_area):
	direction = "left"

func left_area_entered(_area):
	direction = "right"

func up_area_entered(area):
	direction = "down"

func down_area_entered(area):
	direction = "up"
	
func area_exited(_area):
	direction = ""
	
