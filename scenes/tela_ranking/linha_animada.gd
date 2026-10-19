class_name LinhaAnimada extends GridContainer

var tween : Tween
var tweenMouseEntrando : Tween
var tweenMouse : Tween

func _ready() -> void:
	columns = 3
	custom_minimum_size = Vector2(190,100)
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	# Eu acho que o custom_minimum_size não faz nada nesse código? 

	scale = Vector2(0.00, 0.00)
	modulate = 0
	
	mouse_entered.connect(animarMouseEntrando)
	mouse_exited.connect(animarMouseSaindo)
	
func animar() -> void:
	if tween:tween.kill()
	tween = create_tween()
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	tween.tween_property(self, "modulate:a", 1.0, 0.2)

func animarMouseEntrando() -> void:
	if tweenMouseEntrando:tweenMouseEntrando.kill()
	tweenMouseEntrando = create_tween()
	
	tweenMouseEntrando.set_ease(Tween.EASE_OUT)
	tweenMouseEntrando.set_trans(Tween.TRANS_CUBIC)
	tweenMouseEntrando.set_parallel(true)
	
	tweenMouseEntrando.tween_property(self, "scale", Vector2(1.04, 1.04), 0.3)

func animarMouseSaindo() -> void:
	if tweenMouse:tweenMouse.kill()

	tweenMouse = create_tween()
	tweenMouse.set_ease(Tween.EASE_OUT)
	tweenMouse.set_trans(Tween.TRANS_CUBIC)
	tweenMouse.set_parallel(true)

	tweenMouse.tween_property(self,"scale", Vector2.ONE,0.2)
