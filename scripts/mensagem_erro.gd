@abstract
class_name mensagemErro extends RichTextLabel

var tween: Tween

func mostrarMensagem(mensagemErro: String) -> void:
	pivot_offset = size/2
	scale = Vector2.ZERO
	rotation_degrees = 5
	modulate = Color.RED
	
	text = mensagemErro
	show()
	if tween:tween.kill()
	tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	tween.tween_property(self, "rotation_degrees", 0, 0.3)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 0.2).set_delay(2.0)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.2).set_delay(2.0)
