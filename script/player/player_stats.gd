extends Node
class_name PlayerStats

var base_health: int = 10
var base_attack: int = 1
var base_defense: int = 1

var current_health: int
var max_health: int

func _ready() -> void:
	current_health = base_health
	max_health = current_health
	
