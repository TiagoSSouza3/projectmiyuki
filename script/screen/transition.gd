extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var tween = get_tree().create_tween()
var transition_time := 0.5

func _ready():
	Transition.fade_out()
	color_rect.color.a = 0.0
	color_rect.visible = false
	

func trocar_de_cena():
	Transition.fade_in(Callable(self, "trocar_de_cena"))
	get_tree().change_scene_to_file("res://cenas/nova_cena.tscn")

func fade_in(callback: Callable = Callable()):
	color_rect.visible = true
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color:a", 1.0, transition_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	if callback.is_valid():
		tween.tween_callback(callback)

func fade_out():
	tween.kill()
	tween = get_tree().create_tween()
	tween.tween_property(color_rect, "color:a", 0.0, transition_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(Callable(self, "_on_fade_out_finished"))

func _on_fade_out_finished():
	color_rect.visible = false
