extends Node2D

@onready var interaction_area = $InteractionArea
@onready var interaction_label = $InteractionLabel
@onready var dialog_screen = $DialogScreen

var player_in_range = false
var prompt_shown = false

var dialog_lines: Array[String] = [
	"Finalmente acordou, mais uma
	cobaia de testes.",
	"Vá, seja testado, empurre a 
	caixa até o botão e saia daqui."
]

func _ready():
	interaction_label.visible = false
	interaction_area.body_entered.connect(self._on_body_entered)
	interaction_area.body_exited.connect(self._on_body_exited)

func _on_body_entered(body):
	if body.name == "character":
		player_in_range = true
		if not prompt_shown:
			interaction_label.visible = true
			prompt_shown = true

func _on_body_exited(body):
	if body.name == "character":
		interaction_label.visible = false
		player_in_range = false
		dialog_screen.close_dialog()

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interaction_label.visible = false
		if not dialog_screen.is_dialog_active():
			dialog_screen.start_dialog(dialog_lines)
		else:
			dialog_screen.advance_dialog()
