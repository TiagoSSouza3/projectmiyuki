extends TextureRect

var index: int = -1  
var item: String = ""
var item_info: String = ""

@onready var quantity_label: Label = $QuantityLabel

var item_icons = {
	"Pilastra": preload("res://sprites/hold/Pilastra.png"),
}

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	update_slot()

	set_custom_minimum_size(Vector2(64, 64))

func update_slot():
	if item != "":
		if item_icons.has(item):
			texture = item_icons[item]
		else:
			texture = null
		if quantity_label:
			quantity_label.text = item_info
	else:
		texture = null
		if quantity_label:
			quantity_label.text = ""

func get_drag_data(position):
	if item == "":
		return null

	var preview = TextureRect.new()
	preview.texture = texture
	preview.expand = true
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	set_drag_preview(preview)

	return {
		"item": item,
		"item_info": item_info,
		"from_index": index
	}

func can_drop_data(position, data):
	return true

func drop_data(position, data):
	var container = get_parent().get_parent().get_parent() as InventoryContainer
	var from_index = data["from_index"]
	container.swap_items(from_index, index)
	container.update_all_slots()
