extends Area2D

@export var intro_message: String = "O segundo dígito é o triplo do primeiro.
O terceiro é a soma dos dois primeiros.
Achar o maior número possivel"

@export var dialog_box_path: NodePath
@export var password_display: PackedScene
@export var canvas_layer_path: NodePath

@onready var timer: Timer = $Timer

var player_near = false
var ui_instance
var state = 0

func _ready() -> void:
	$InteractionLabel.visible = false
	$InteractionArea.body_entered.connect(self._on_body_entered)
	$InteractionArea.body_exited.connect(self._on_body_exited)

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		var dialog_box = get_node(dialog_box_path)
		
		if state == 0:
			dialog_box.show_text(intro_message)
			if not dialog_box.is_connected("dialogue_finished", Callable(self, "_on_dialogue_finished")):
				dialog_box.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
			get_tree().paused = true
			
		elif state == 1 and password_display and not ui_instance:
			var canvas_layer = get_node(canvas_layer_path)
			ui_instance = password_display.instantiate()
			ui_instance.connect("password_closed", Callable(self, "_on_password_closed"))
			canvas_layer.add_child(ui_instance)
			get_tree().paused = true
			

func close_ui():
	if ui_instance:
		ui_instance.close()
		ui_instance = null
		state = 1

func _on_password_closed():
	ui_instance = null
	get_tree().paused = false
	state = 1

func _on_dialogue_finished():
	get_tree().paused = false
	state = 1
	
	if password_display and not ui_instance:
		var canvas_layer = get_node(canvas_layer_path)
		ui_instance = password_display.instantiate()
		ui_instance.connect("password_closed", Callable(self, "_on_password_closed"))
		canvas_layer.add_child(ui_instance)
		get_tree().paused = true

func _on_body_entered(body):
	if body.name == "character":
		$InteractionLabel.visible = true
		player_near = true

func _on_body_exited(body):
	if body.name == "character":
		$InteractionLabel.visible = false
		player_near = false
		
		
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if ui_instance:
			close_ui()
		elif state == 0:
			pass
