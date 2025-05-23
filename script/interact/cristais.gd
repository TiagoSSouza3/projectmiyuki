extends Node2D

const MAX_SELECTION := 3
const MAX_PUZZLES := 4

@export_multiline var dialogue_text: String = ""
@export_multiline var dialogue_text2: String = ""
@export_multiline var dialogue_text3: String = ""
@export_multiline var dialogue_text4: String = ""
@export_multiline var dialogue_text5: String = ""
@export var dialog_container: Node = null
@export var label: Label

@export var crystal_nodes: Array[NodePath]
@export var transmute_crystal_path: NodePath

var selected_ids: Array[int] = []
var current_puzzle := 0

var active_crystal: Node = null
var puzzle_solutions := [
	[3, 2, 4],
	[5, 0, 1],
	[4, 0, 2],
	[1, 4, 0],
]

var transmute_crystal: Node = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	transmute_crystal = get_node(transmute_crystal_path)
	for path in crystal_nodes:
		var crystal = get_node(path)
		crystal.connect("player_entered", Callable(self, "_on_crystal_entered").bind(crystal))
		crystal.connect("player_exited", Callable(self, "_on_crystal_exited").bind(crystal))
	
	transmute_crystal = get_node(transmute_crystal_path)
	transmute_crystal.connect("player_entered", Callable(self, "_on_crystal_entered").bind(transmute_crystal))
	transmute_crystal.connect("player_exited", Callable(self, "_on_crystal_exited").bind(transmute_crystal))

func _process(_delta):
	if Input.is_action_just_pressed("interact") and active_crystal:
		_select_crystal(active_crystal)

func _select_crystal(crystal):
	if "is_transmuter" in crystal and crystal.is_transmuter:
		_attempt_transmutation()
		return

	var id = crystal.element_id
	if selected_ids.size() >= MAX_SELECTION and Input.is_action_just_pressed("interact"):
		interact()
		get_tree().paused = true
		return
	if id in selected_ids:
		interact()
		get_tree().paused = true
		return

	selected_ids.append(id)
	
	if crystal and crystal.idle_sprite and crystal.idle_sprite.sprite_frames:
		crystal.idle_sprite.animation = crystal.animation_name
		crystal.idle_sprite.play()
		
	
func interact():
	if dialog_container:
		dialog_container.show_text(dialogue_text)
		label.visible = true
		
	
func interact2():
	if dialog_container:
		dialog_container.show_text(dialogue_text2)
		label.visible = true
		
	
func interact3():
	if dialog_container:
		dialog_container.show_text(dialogue_text3)
		label.visible = true
		
func interact4():
	if dialog_container:
		dialog_container.show_text(dialogue_text4)
		label.visible = true
		
	
func interact5():
	if dialog_container:
		dialog_container.show_text(dialogue_text5)
		label.visible = true

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		dialog_container.hide()
		get_tree().paused = false
		label.visible = false

func _attempt_transmutation():
	if selected_ids.size() != MAX_SELECTION:
		interact2()
		get_tree().paused = true
		return
		
	if transmute_crystal and transmute_crystal.idle_sprite:
		transmute_crystal.idle_sprite.animation = transmute_crystal.animation_name
		transmute_crystal.idle_sprite.play()
		
	var correct = puzzle_solutions[current_puzzle]
	if selected_ids == correct:
		interact4()
		get_tree().paused = true
		current_puzzle += 1
	else:
		interact3()
		get_tree().paused = true

	selected_ids.clear()

	if current_puzzle >= MAX_PUZZLES:
		interact5()
		get_tree().paused = true
		set_physics_process(false)
		await get_tree().create_timer(2).timeout
		var transition = get_node("/root/Transition")
		transition.fade_in(Callable(self, "_end_game"))
		

func _end_game():
	get_tree().change_scene_to_file("res://scene/worlds/title_screen.tscn")

func _on_crystal_entered(crystal):
	active_crystal = crystal

func _on_crystal_exited(crystal):
	if active_crystal == crystal:
		active_crystal = null
