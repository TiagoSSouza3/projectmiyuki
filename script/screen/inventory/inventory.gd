extends Control
class_name InventoryContainer

@onready var slot_container: GridContainer = $VContainer/Bg/GridContainer

var current_state: String

var index: int = -1
var can_click: bool = false
var is_visible: bool = false

var item_index: int

var slot_item_info: Array = [
	"1",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	""
]

var slot_list: Array = [
	"pilastra",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	"",
	""
]

func _ready() -> void:
	for i in range(slot_container.get_child_count()):
		var child = slot_container.get_child(i)
		child.index = i  
		child.item = slot_list[i]
		child.item_info = slot_item_info[i]
		child.update_slot()
		child.connect("empty_slot", Callable(self, "empty_slot"))
		
	if Input.is_action_just_pressed("open"):
		InventoryContainer.visible = true
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		queue_free()
		get_tree().paused = false
	
func swap_items(from_index: int, to_index: int):
	var temp_item = slot_list[to_index]
	var temp_info = slot_item_info[to_index]

	slot_list[to_index] = slot_list[from_index]
	slot_item_info[to_index] = slot_item_info[from_index]

	slot_list[from_index] = temp_item
	slot_item_info[from_index] = temp_info

func update_all_slots():
	for i in range(slot_container.get_child_count()):
		var slot = slot_container.get_child(i)
		slot.index = i
		slot.item = slot_list[i]
		slot.item_info = slot_item_info[i]
		slot.update_slot()
		
func empty_slot(index: int):
	slot_list[index] = ""
	slot_item_info[index] = ""
