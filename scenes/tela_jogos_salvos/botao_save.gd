class_name BotaoSave extends Panel
var tweenReady: Tween
var tweenHover: Tween
var estilo: StyleBoxFlat
@export var TituloEvento : String
@export var Pontos : String
@export var idJogo : String
signal savePressionado

func _ready() -> void:
	estilo = get_theme_stylebox("panel").duplicate()
	add_theme_stylebox_override("panel", estilo)
	
	$TituloEvento.text = TituloEvento
	$TituloEvento.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$Pontos.text = Pontos
	$Pontos.mouse_filter = Control.MOUSE_FILTER_IGNORE
	modulate.a = 0.0
	await get_tree().process_frame
	
	scale = Vector2(0.0, 1.0)
	animar()
	
	
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed(): 
		savePressionado.emit(idJogo)

func animar() -> void:
	if tweenReady:tweenReady.kill()
	tweenReady = create_tween()
	
	tweenReady.set_parallel(true)
	tweenReady.set_trans(Tween.TRANS_CUBIC)
	tweenReady.set_ease(Tween.EASE_OUT)
	tweenReady.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3)
	tweenReady.tween_property(self, "modulate:a", 1.0, 0.3)

func _on_mouse_entered() -> void:
	print("Mouse entrou no botão de save!")
	pivot_offset = size/2
	if tweenHover:tweenHover.kill()
	tweenHover = create_tween()
		
	tweenHover.set_trans(Tween.TRANS_CUBIC)
	tweenHover.set_ease(Tween.EASE_OUT)
	tweenHover.set_parallel(true)
	tweenHover.tween_property(estilo, "border_width_left", 8, 0.2)
	tweenHover.tween_property(estilo, "border_width_right", 8, 0.2)
	tweenHover.tween_property(estilo, "border_width_top", 8, 0.2)
	tweenHover.tween_property(estilo, "border_width_bottom", 8, 0.2)
	
func _on_mouse_exited() -> void:
	print("Mouse saiu do botão de save!")
	pivot_offset = size/2
	if tweenHover:tweenHover.kill()
	tweenHover = create_tween()
		
	tweenHover.set_trans(Tween.TRANS_CUBIC)
	tweenHover.set_ease(Tween.EASE_OUT)
	tweenHover.set_parallel(true)
	tweenHover.tween_property(estilo, "border_width_left", 0, 0.2)
	tweenHover.tween_property(estilo, "border_width_right", 0, 0.2)
	tweenHover.tween_property(estilo, "border_width_top", 0, 0.2)
	tweenHover.tween_property(estilo, "border_width_bottom", 0, 0.2)
