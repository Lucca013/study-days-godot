class_name menuEstilizado extends Panel
var tween : Tween 

func _ready() -> void:
	modulate = Color.TRANSPARENT
	scale = Vector2.ZERO
	pivot_offset = size/2
	animacaoMenu()
		
func animacaoMenu():
	if tween:tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUART)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
