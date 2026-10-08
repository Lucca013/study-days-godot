extends Button
class_name botaoEstilizado

var tween: Tween
var hoverStylebox : StyleBox

func _ready() -> void:
	hoverStylebox = get_theme_stylebox("hover").duplicate()
	add_theme_stylebox_override("hover", hoverStylebox)
	
	pivot_offset = size/2
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	if tween:tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.5)
	tween.tween_property(hoverStylebox, "border_width_left", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_right", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_top", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_bottom", 4, 0.5)

func _on_mouse_exited():
	if tween:tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 0.5)
	tween.tween_property(hoverStylebox, "border_width_left", 0, 0.5)
	tween.tween_property(hoverStylebox, "border_width_right", 0, 0.5)
	tween.tween_property(hoverStylebox, "border_width_top", 0, 0.5)
	tween.tween_property(hoverStylebox, "border_width_bottom", 0, 0.5)
