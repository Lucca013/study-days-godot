class_name CaixaDialogo extends Control

@export var nomePersonagem : String="Lotad"
@export var dialogo : String="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lorem est, molestie sit amet gravida in, consectetur in dui. Suspendisse potenti. Donec tempor nec augue quis scelerisque. Sed in faucibus sapien.":
	set(n):
		dialogo=n
		definirTexto()
var tween : Tween
var textoFinalizado: bool = false

func _ready() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PainelDialogo/PanelContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Dialogo.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PainelDialogo/Panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%NomePersonagem.mouse_filter = Control.MOUSE_FILTER_IGNORE
	$PainelDialogo.mouse_filter = Control.MOUSE_FILTER_STOP
	
	$PainelDialogo.gui_input.connect(skipparTexto)
	$PainelDialogo.scale = Vector2(1.0, 0.9)
	
	animarEntrada()
	definirTexto()

func definirTexto() -> void:
	if ! is_node_ready():
		return	

	%Dialogo.text = dialogo
	%NomePersonagem.text = nomePersonagem
	%Dialogo.visible_ratio = 0
		
	if tween:tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(%Dialogo, "visible_ratio", 1, (dialogo.length() / 30) + 0.5)
	await tween.finished
	tween = null
	textoFinalizado = true 
func skipparTexto(event : InputEvent) -> void:
	if ! is_node_ready():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if(textoFinalizado):
			self.queue_free()
		else:
			if tween and tween.is_running():
				tween.kill()
				tween = null
				%Dialogo.visible_ratio = 1
				textoFinalizado = true
			else:
				definirTexto()

func animarEntrada() -> void:
	var tweenDialogBox : Tween = get_tree().create_tween()
	tweenDialogBox.set_trans(Tween.TRANS_CUBIC)
	tweenDialogBox.set_ease(Tween.EASE_IN)
	tweenDialogBox.tween_property($PainelDialogo, "scale", Vector2(1.0, 1.0), 0.2)
	
