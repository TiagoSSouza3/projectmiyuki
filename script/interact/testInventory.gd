extends TextureButton

@onready var icon = $Icon
@onready var count_label = $Count

var item_data = null
var inventory_ui = null

func _ready():
	update_slot()

func set_item(data):
	item_data = data
	if data:
		$Icon.texture = data.icon
	else:
		$Icon.texture = null

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if item_data and inventory_ui:
			inventory_ui.start_drag(self)

func get_drag_data(position):
	if item_data == null:
		return null

func can_drop_data(_position, data):
	return data.has("item")
	return data is InventorySlot

func drop_data(_position, data):
	if data.has("item") and data.has("from_slot"):
		var from_slot = data["from_slot"]
		var temp = item_data

		item_data = from_slot.item_data
		from_slot.item_data = temp

		update_slot()
		from_slot.update_slot()
		

func update_slot():
	if item_data:
		icon.texture = item_data.icon
		count_label.text = str(item_data.count)
		icon.visible = true
		count_label.visible = item_data.count > 1
	else:
		icon.texture = null
		count_label.text = ""
		icon.visible = false
		count_label.visible = false

	var drag_preview = icon.duplicate()
	set_drag_preview(drag_preview)

	return {"item": item_data, "from_slot": self}
