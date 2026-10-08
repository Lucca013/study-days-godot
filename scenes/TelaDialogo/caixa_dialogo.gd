extends Control
@export var nomePersonagem:String="Lotad"
@export var dialogo:String="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas lorem est, molestie sit amet gravida in, consectetur in dui. Suspendisse potenti. Donec tempor nec augue quis scelerisque. Sed in faucibus sapien.":
	set(n):
		dialogo=n
		definirTexto()
var tween : Tween

func _ready():
	gui_input.connect(skipparTexto)
	definirTexto()

func definirTexto():
	if ! is_node_ready():
		return	

	%Dialogo.text = dialogo
	%nomePersonagem.text = nomePersonagem
	%Dialogo.visible_ratio = 0
		
	if tween:tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(%Dialogo, "visible_ratio", 1, (dialogo.length() / 30) + 0.5)
	await tween.finished
	tween = null
	
func skipparTexto(event: InputEvent):
	if ! is_node_ready():
		return
	
	if event is InputEventMouseButton and event.is_pressed(): 
		if tween and tween.is_running():
			tween.kill()
			%Dialogo.visible_ratio = 1
		else:
			definirTexto()
