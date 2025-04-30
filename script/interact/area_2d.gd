extends Area2D

@export var direction: String = ""
var box: Node = null

func connect_to_box(box_node: Node):
	box = box_node
	print(name, "conectado ao Box com direção:", direction)
	connect("area_shape_entered", Callable(self, "_on_area_entered"))
	connect("area_shape_exited", Callable(self, "_on_area_exited"))

func _on_area_entered(_rid: RID, area: Area2D, _asi: int, _lsi: int):
	if area.is_in_group("character") and box:
		print(name, ": personagem entrou na direção", direction)
		box.direction = direction

func _on_area_exited(_rid: RID, area: Area2D, _asi: int, _lsi: int):
	if area.is_in_group("character") and box:
		print(name, ": personagem saiu da direção", direction)
		box.direction = ""
