extends Node

signal transition_scene

@export var scene_path: String = ""
@export var next_spawn_door: String = ""
@export var next_spawn: String = ""

func _ready():
	transition_scene.connect(_on_transition_scene)


func _on_transition_scene():
	if scene_path.is_empty():
		return
	if not ResourceLoader.exists(scene_path):
		push_error("Cena não encontrada: " + scene_path)
		return

	GameState.next_spawn_point_door = next_spawn_door
	GameState.next_spawn_point = next_spawn

	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file(scene_path)
