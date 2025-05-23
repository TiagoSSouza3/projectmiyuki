extends Node2D

@export_multiline var dialogue_text: String = ""
@export var dialog_container: Node = null

@onready var interaction_area = $InteractionArea
@onready var interaction_label = $InteractionLabel

var player_in_range := false
var prompt_shown = false

func _ready():
	interaction_label.visible = false
	dialog_container.dialogue_finished.connect(_on_dialogue_finished)

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		interact()

func interact():
	if dialog_container:
		dialog_container.show_text(dialogue_text)
		$InteractionLabel.visible = false

func _on_dialogue_finished():
	print("Diálogo com NPC finalizado.")


func _on_body_entered(body):
	if body.name == "character":
		player_in_range = true
		interaction_label.visible = true

func _on_body_exited(body):
	if body.name == "character":
		player_in_range = false
		dialog_container.visible = false
		interaction_label.visible = false
