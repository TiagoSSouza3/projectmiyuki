extends Control
class_name PasswordDisplay

@export var correct_password: String = "1234"
var current_input := ""

@onready var display = $Panel/Display
@onready var buttons = $Panel/Keypad.get_children()

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
		get_tree().paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

	if display:
		display.process_mode = Node.PROCESS_MODE_ALWAYS


	var keypad = $Panel.get_node("Keypad")
	if keypad:
		var buttons = keypad.get_children()
		for button in buttons:
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
	print("Cofre Aberto!")
	SignalManager.open_door_tutorial.emit()
	SignalManager.open_safe.emit()
	await get_tree().create_timer(1).timeout
	queue_free() 
	get_tree().paused = false
