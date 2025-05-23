extends Node2D
class_name DoorLevel

const REQUIRED_KEYS := 3

@export var intro_message: String = "Essa porta está trancada com 3 cadeados, pegue as 3 chaves nas salas adjacentes e destranque-os."
@export var dialog_box_path: NodePath

var player_near = false
var transition: Node = null
var can_teleport := false
var dialog_open = false

@onready var label: Label = $Label
@onready var transition_node = get_parent().get_node("DoorUp/TransitionScene")

func _ready():
	process_mode = Node2D.PROCESS_MODE_ALWAYS
	set_process_unhandled_input(true)
	label.visible = false
	transition = get_node("/root/Transition")

func _process(_delta):
	if can_teleport and Input.is_action_just_pressed("interact") and player_near and not dialog_open:
		if GameState.key_count >= 3:
			if transition_node:
				transition_node.transition_scene.emit()
				Transition.fade_in()
		else:
			var dialog_box = get_node_or_null(dialog_box_path)
			if dialog_box:
				dialog_box.show_text(intro_message)
				dialog_open = true
				get_tree().paused = true
			else:
				print("ERRO: dialog_box_path não está definido ou é inválido!")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		var dialog_box = get_node_or_null(dialog_box_path)
		get_tree().paused = false
		if dialog_box:
			dialog_box.hide()
		dialog_open = false

func _on_body_entered(body: Node) -> void:
	if body.name == "character":
		label.visible = true
		player_near = true
		can_teleport = true

func _on_body_exited(body: Node) -> void:
	if body.name == "character":
		label.visible = false
		player_near = false
		can_teleport = false
