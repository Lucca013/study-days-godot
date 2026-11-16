class_name PersonagemBase extends TextureRect

var tween : Tween
var posicao : Node 

func _ready() -> void:
	pass

func snap(target: Node) -> void: 
	if tween:tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", target.position, 0.2)

func move(target: Node) -> void: 
	if tween:tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", target.position, 0.5)
