extends Node2D
class_name Chest

@export var chave_id: String = "bau_1"

var is_open := false
var collected := false

func _ready() -> void:
	if GameState.tem_chave(chave_id):
		collected = true
		$Key.visible = false
		$Texture/Animation.play("open")
		return
	
	if SignalManager.open_door_tutorial:
		SignalManager.all_buttons_pressed.connect(open_chest)
		SignalManager.open_safe.connect(open_chest)
		SignalManager.lever_is_pressed.connect(open_chest)
	else:
		SignalManager.not_all_buttons_pressed.connect(close_chest)
		$Texture/Animation.play("RESET")
		
	
	
func open_chest():
	$Texture/Animation.play("open")
	$Key.visible = true
	is_open = true
	$Key/AnimatedSprite2D.play("key")
	
func close_chest():
	$Texture/Animation.play("RESET")
	$Key.visible = false
	is_open = false

func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.is_in_group("character"):
		$Key.visible = false
		collected = true
		GameState.pegar_chave(chave_id)
		if body.has_method("collect_key"):
			body.collect_key()

func _on_area_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var body = area.get_parent()
	if collected or not is_open:
		return
	if body.is_in_group("character"):
		$Key.visible = false
		collected = true
		GameState.pegar_chave(chave_id)
		if body.has_method("collect_key"):
			body.collect_key()
