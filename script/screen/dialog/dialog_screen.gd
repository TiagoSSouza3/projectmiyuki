extends Control

@onready var dialog_box = $DialogBox
@onready var dialog_label = $DialogBox/DialogLabel

var dialog_lines: Array[String] = []
var current_dialog_index: int = 0
var is_dialog_open: bool = false

func _ready():
	dialog_box.visible = false
	dialog_label.text = ""

func start_dialog(lines: Array[String]):
	if lines.is_empty():
		return
	for line in lines:
		if not line is String:
			push_error("DialogSystem: Found non-string element in dialog_lines: %s" % str(line))
			return
	dialog_lines = lines
	current_dialog_index = 0
	is_dialog_open = true
	dialog_box.visible = true
	dialog_label.text = dialog_lines[current_dialog_index]

func advance_dialog():
	if not is_dialog_open:
		return
	current_dialog_index += 1
	if current_dialog_index < dialog_lines.size():
		dialog_label.text = dialog_lines[current_dialog_index]
	else:
		close_dialog()

func close_dialog():
	is_dialog_open = false
	dialog_box.visible = false
	current_dialog_index = 0
	dialog_label.text = ""
	dialog_lines.clear()

func is_dialog_active() -> bool:
	return is_dialog_open
