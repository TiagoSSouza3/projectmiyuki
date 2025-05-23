extends Area2D

signal player_entered
signal player_exited

@onready var idle_sprite := $IdleSprite

@export var animation_name: String = ""
@export var element_id: int
@export var is_transmuter: bool = false

func _ready():
	if animation_name != "":
		idle_sprite.animation = animation_name
		idle_sprite.frame = 0
		idle_sprite.pause()
		
	idle_sprite.animation_finished.connect(_on_animation_finished)

func play_animation():
	if animation_name != "":
		idle_sprite.animation = animation_name
		idle_sprite.play()

func _on_animation_finished():
	idle_sprite.frame = 0
	idle_sprite.pause()
	
func _on_body_entered(body):
	if body.name == "character":
		emit_signal("player_entered")

func _on_body_exited(body):
	if body.name == "character":
		emit_signal("player_exited")
