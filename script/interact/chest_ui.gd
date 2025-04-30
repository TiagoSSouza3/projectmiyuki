extends CanvasLayer
@export var slot_scene: PackedScene
@onready var grid_container = $TextureRect/GridContainer

var dragging_slot = null
var item_list = []

class Item:
	var name = ""
	var icon = null

func _ready():
	create_slots(0)
	create_fake_items()
	populate_inventory()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
		get_tree().paused = false

func create_slots(amount):
	for i in amount:
		var slot = slot_scene.instantiate()
		slot.inventory_ui = self 
		grid_container.add_child(slot)

func create_fake_items():
	for i in 8:
		var item = Item.new()
		item.name = "Item " + str(i)
		item.icon = preload("res://sprites/hold/armadilha/armadilha espinho 1.png")
		item_list.append(item)

func populate_inventory():
	for i in item_list.size():
		var slot = grid_container.get_child(i)
		slot.set_item(item_list[i])

func start_drag(from_slot):
	dragging_slot = from_slot

func try_drop(to_slot):
	if dragging_slot and to_slot != dragging_slot:
		var temp = to_slot.item_data
		to_slot.set_item(dragging_slot.item_data)
		dragging_slot.set_item(temp)
		dragging_slot = null
