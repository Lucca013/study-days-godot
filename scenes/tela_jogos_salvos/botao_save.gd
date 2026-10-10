class_name BotaoSave extends Panel
var tween: Tween
@export var TituloEvento : String
@export var Pontos : String
@export var idJogo : String
signal savePressionado
# só vou precisar conectar o signal quando o botão é instanciado na tela p funcionar 

func _ready() -> void:
	$TituloEvento.text = TituloEvento
	$Pontos.text = Pontos
	
	await get_tree().process_frame
	
	rotation_degrees = -1.0
	scale = Vector2.ZERO
	animar()
	
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed(): 
		savePressionado.emit(idJogo)

func animar():
	if tween:tween.kill()
	tween = create_tween()
	
	tween.set_parallel(true)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "rotation_degrees", 0, 0.3)
	tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
