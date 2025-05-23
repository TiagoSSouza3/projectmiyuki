extends Area2D

@export var intro_message: String = "Você escuta vozes vindo do pilar. Um teste.

'O segundo dígito é o triplo do primeiro,
 O terceiro é a soma dos dois primeiros.'
 Qual o maior número formado seguindo essa regra?

'A+B+C=26
A+A+B=19
C+B+B= 33
3C+B+2A=??'
Qual o resultado da 4 conta?

'41, 132, 213, 294, ...'
Qual o quinto número da lista?

Some os resultados de cada problema e diga ao pilar.
"

@export var chave_id: String = "bau_2"
@export var dialog_box_path: NodePath
@export var password_display: PackedScene
@export var canvas_layer_path: NodePath

var player_near = false
var ui_instance: Node = null
var state := 0

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$InteractionLabel.visible = false
	$InteractionArea.body_entered.connect(_on_body_entered)
	$InteractionArea.body_exited.connect(_on_body_exited)
	
	if GameState.tem_chave(chave_id):
		set_process(false)
		$InteractionLabel.visible = false
		$InteractionArea.set_monitoring(false)

func _process(_delta):
	if player_near and Input.is_action_just_pressed("interact"):
		var dialog_box = get_node_or_null(dialog_box_path)
		if not dialog_box:
			return

		if state == 0:
			dialog_box.show_text(intro_message)
			if not dialog_box.is_connected("dialogue_finished", Callable(self, "_on_dialogue_finished")):
				dialog_box.connect("dialogue_finished", Callable(self, "_on_dialogue_finished"))
			get_tree().paused = true

		elif state == 1 and password_display and not ui_instance:
			var canvas_layer = get_node_or_null(canvas_layer_path)
			if not canvas_layer:
				return
			ui_instance = password_display.instantiate()
			ui_instance.connect("password_closed", Callable(self, "_on_password_closed"))
			canvas_layer.add_child(ui_instance)
			get_tree().paused = true

func _on_dialogue_finished():
	get_tree().paused = false
	state = 1
	if password_display and not ui_instance:
		var canvas_layer = get_node_or_null(canvas_layer_path)
		if not canvas_layer:
			return
		ui_instance = password_display.instantiate()
		ui_instance.connect("password_closed", Callable(self, "_on_password_closed"))
		canvas_layer.add_child(ui_instance)
		get_tree().paused = true

func _on_password_closed():
	if ui_instance:
		ui_instance.queue_free()
	ui_instance = null
	get_tree().paused = false
	state = 1

func close_ui():
	if ui_instance:
		ui_instance.queue_free()
		ui_instance = null
		get_tree().paused = false
		state = 1

func _on_body_entered(body):
	if body.name == "character":
		$InteractionLabel.visible = true
		player_near = true

func _on_body_exited(body):
	if body.name == "character":
		$InteractionLabel.visible = false
		player_near = false
		if ui_instance:
			close_ui()
		state = 0

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		if ui_instance:
			close_ui()
