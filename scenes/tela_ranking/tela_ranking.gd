extends Control

@export var tabela : VBoxContainer 
@export var api : Node 

func _ready() -> void:
	api.gerarRanking()

func _on_dados_recebidos(retorno : Variant) -> void:
	print("_on_dados_recebidos signal emitido")
	print(retorno)
	construir_tela(retorno)

func construir_tela(dados : Variant) -> void:
	print("função construir tela")
	var posicao : int
	posicao = 0 
	var nome : String
	var valorPontuacao : String
	
	for linha : Variant in dados:
		posicao += 1
		nome = linha["jogador"]["nome"]
		valorPontuacao = str(linha["valorPontuacao"])
		var LabelPosicao : Node = LabelTabela.new()
		LabelPosicao.text = str(posicao) 
		var LabelNome : Node = LabelTabela.new()
		LabelNome.text = nome 
		var LabelPontuacao : Node = LabelTabela.new()
		LabelPontuacao.text = valorPontuacao
		var linhaAnimada : LinhaAnimada = LinhaAnimada.new() 
		linhaAnimada.add_child(LabelPosicao)
		linhaAnimada.add_child(LabelNome)
		linhaAnimada.add_child(LabelPontuacao)
		tabela.add_child(linhaAnimada)

		await get_tree().process_frame
		linhaAnimada.animar()
		await Global.wait(0.12)

func _on_menu_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true)
