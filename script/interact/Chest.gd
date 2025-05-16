extends Node2D
class_name Chest

var collected := false

func _ready() -> void:
	$AreaDetec/CollisionDetec.disabled = true
	if SignalManager.open_door_tutorial:
		SignalManager.all_buttons_pressed.connect(open_chest)
		SignalManager.open_safe.connect(open_chest)
		SignalManager.lever_is_pressed.connect(open_chest)
	else:
		SignalManager.not_all_buttons_pressed.connect(close_chest)
		$Texture/Animation.play("RESET")
		
	$AreaDetec.body_entered.connect(_on_body_entered)
	
	
func open_chest():
	$Texture/Animation.play("open")
	$Key.visible = true
	$AreaDetec/CollisionDetec.disabled = false
	$Key/AnimatedSprite2D.play("key")
	
func close_chest():
	$Texture/Animation.play("RESET")
	$Key.visible = false

func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	if body.is_in_group("character"):
		$Key.visible = false
		collected = true
		if body.has_method("collect_key"):
			body.collect_key()
