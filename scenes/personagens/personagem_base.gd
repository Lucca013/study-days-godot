class_name PersonagemBase extends TextureRect

var tween : Tween
var posicao : Node 

## Eu vou considerar que por default eles olham para a direita, se isso fizer sentido

func _ready() -> void:
	position = posicao.position ## Aqui ele sempre deveria receber far right ou far left 

func snap(target: Node) -> void: 
	if tween:tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", target.position, 0.2)

func move(target: Node) -> void: 
	if tween:tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", target.position, 0.5)
