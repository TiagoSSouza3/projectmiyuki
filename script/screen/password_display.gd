extends Control
class_name PasswordDisplay

signal password_closed

@export var correct_password: String = "695"
var current_input := ""

@onready var display = $Panel/Display
@onready var buttons = $Panel/Keypad.get_children()

func _ready():
	if display:
		display.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

	if $Panel/Keypad:
		for button in $Panel/Keypad.get_children():
			if button:
				button.process_mode = Node.PROCESS_MODE_ALWAYS
				button.pressed.connect(_on_button_pressed.bind(button.text))

func _on_button_pressed(value: String):
	match value:
		"OK":
			if current_input == correct_password:
				display.text = "Acesso Liberado"
				_unlock_safe()
			else:
				display.text = "Acesso Negado"
				current_input = ""
		"Clear":
			current_input = ""
			display.text = ""
		_:
			if current_input.length() < 8:
				current_input += value
				display.text = current_input

func _unlock_safe():
	SignalManager.open_door_tutorial.emit()
	SignalManager.open_safe.emit()
	await get_tree().create_timer(1).timeout
	close()

func close():
	emit_signal("password_closed")
	queue_free()
	get_tree().paused = false
