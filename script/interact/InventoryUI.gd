extends TextureButton
class_name InventorySlot

@onready var icon = $Icon
@onready var count_label = $Count

var item_data = {
	"icon": preload("res://sprites/hold/armadilha/armadilha espinho 1.png"),
	"count": 1
}
var inventory_ui = null

func _ready():
	icon.texture = item_data.icon
	update_slot()

func set_item(data):
	item_data = data
	if data:
		$Icon.texture = data.icon
	else:
		$Icon.texture = null

func get_drag_data(position):
	if item_data == null:
		return null

	var preview = icon.duplicate()
	set_drag_preview(preview)

	print("Arrastando item!")
	return {"item": item_data, "from_slot": self}

func can_drop_data(_position, data):
	return data.has("item")

func drop_data(_position, data):
	print("Drop detectado:", data)
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
