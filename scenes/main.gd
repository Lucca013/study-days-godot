class_name GameController extends Control

@export var tela: Control
var telaAtual : Node

func _ready() -> void:
	Global.game_controller = self
	mudarTela("res://scenes/tela_cadastro/tela_cadastro.tscn", true)
	
func mudarTela(novaCena: String, deletar: bool) -> void: 
	if(telaAtual != null):
		if(deletar):
			telaAtual.queue_free()
		#else:
			#telaAtual.hide()
	var nova_tela : Node = load(novaCena).instantiate()
	tela.add_child(nova_tela) 
	telaAtual = nova_tela

func sairJogo() -> void: 
	get_tree().quit()
