class_name GameController extends Control

@export var tela: Control
var telaAtual 

func _ready() -> void:
	Global.game_controller = self
	mudarTela("res://scenes/tela_cadastro/tela_cadastro.tscn", true)
	
func mudarTela(novaCena: String, deletar: bool):
	if(telaAtual != null):
		if(deletar):
			telaAtual.queue_free()
		else:
			telaAtual.hide()
	var nova_tela = load(novaCena).instantiate()
	tela.add_child(nova_tela)
	telaAtual = nova_tela

func sairJogo():
	get_tree().quit()
