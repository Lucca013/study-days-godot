extends Control

signal telaMenu

func _ready() -> void:
	$ApiTelaRanking.requisicaoGet()

func _on_dados_recebidos(retorno):
	print("_on_dados_recebidos signal emitido")
	print(retorno)
	construir_tela(retorno)

func construir_tela(dados):
	print("função construir tela")
	var posicao : int
	posicao = 0 
	var nome
	var valorPontuacao
	
	for linha in dados:
		posicao += 1
		nome = linha["jogador"]["nome"]
		valorPontuacao = linha["valorPontuacao"]
		var LabelPosicao = LabelTabela.new()
		LabelPosicao.text = str(posicao) 
		var LabelNome = LabelTabela.new()
		LabelNome.text = nome
		var LabelPontuacao = LabelTabela.new()
		LabelPontuacao.text = str(valorPontuacao)
		%tabela.add_child(LabelPosicao)
		%tabela.add_child(LabelNome)
		%tabela.add_child(LabelPontuacao)


func _on_menu_pressed() -> void:
	telaMenu.emit()
