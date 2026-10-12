extends Label
class_name LabelTabela 

var tween : Tween

func _ready() -> void:
	custom_minimum_size = Vector2(190,100)
	set("theme_override_colors/font_color", Color(0.0, 0.0, 0.0, 1.0))
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	scale = Vector2(0.00, 0.00)
	modulate = 0
	
func animar() -> void:
	if tween:tween.kill()
	tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	tween.tween_property(self, "modulate:a", 1.0, 0.2)
	
