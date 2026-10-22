extends Control
var tween : Tween
var tweenSaida : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	if tween:tween.kill()
	tween = create_tween()
	
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	
	tween.tween_property(self, "modulate:a", 1, 0.4)
	await tween.finished
	await Global.wait(1.5)
	
	tweenSaida = create_tween()
	tweenSaida.tween_property(self, "modulate:a", 0, 0.4)
	await tweenSaida.finished
	
	Global.game_controller.mudarTela("res://scenes/tela_login/tela_login.tscn", true)
	
