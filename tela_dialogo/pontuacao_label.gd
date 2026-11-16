extends RichTextLabel

var tweenEntrada : Tween
var tweenSaida : Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pivot_offset = size/2

func atualizarPontuacaoInicio(pontuacao : int) -> void:
	var pontuacaoTotal : int = (Save.pontuacaoAtual + pontuacao)
	text = "Pontuação: " + str(pontuacaoTotal)
	
	if tweenEntrada:tweenEntrada.kill()
	tweenEntrada = get_tree().create_tween()
	tweenEntrada.set_parallel(true)
	tweenEntrada.set_ease(Tween.EASE_IN)
	tweenEntrada.set_trans(Tween.TRANS_CUBIC)
	
	if(pontuacao > 0):
		add_theme_color_override("default_color", Color.GREEN)
	else:
		add_theme_color_override("default_color", Color.RED)
	tweenEntrada.tween_property(self, "scale", Vector2(1.10, 1.0), 0.5)
	await Global.wait(1.0)
	add_theme_color_override("default_color", Color.BLACK)
	
	tweenSaida = get_tree().create_tween()
	tweenSaida.set_parallel(true)
	tweenSaida.tween_property(self, "scale", Vector2.ONE, 0.5)
