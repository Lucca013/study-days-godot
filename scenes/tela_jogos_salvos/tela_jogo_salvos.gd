extends Control

func _ready() -> void:
	$ApiListarJogos.requisicaoGet()

func _on_api_listar_jogos_api_retorno(retorno : Variant) -> void:
	if(retorno != null):
		construirTela(retorno)

func construirTela(dados: Variant) -> void:
	print("função construir tela")
	var posicao : int
	posicao = 0 
	var idJogo : String
	var eventoAtualTitulo : String
	var valorPontuacao : String

	for linha : Variant in dados:
		posicao += 1
		idJogo = str(linha["id"])
		eventoAtualTitulo = str(linha["eventoAtual"]["titulo"])
		valorPontuacao = str(linha["pontuacaoAtual"])
		valorPontuacao = "Pontuação: "+valorPontuacao
				
		var botaoSave : Node = preload("res://scenes/tela_jogos_salvos/botao_save.tscn").instantiate()
		botaoSave.TituloEvento = eventoAtualTitulo
		botaoSave.Pontos = valorPontuacao
		botaoSave.idJogo = idJogo
		print("Botão com "+idJogo + " idJogo instanciado!")
		botaoSave.savePressionado.connect(_on_save_pressionado)
		
		$Panel/ScrollContainer/VBoxContainer.add_child(botaoSave)
		await Global.wait(0.2)
		
func _on_save_pressionado(idJogo : String) -> void:
	print("Botão pressionado!")
	print("Id do jogo pressionado é:" +str(idJogo))
	Save.idJogoAtual = int(idJogo)
	Global.game_controller.mudarTela("res://scenes/tela_dialogo/tela_dialogo.tscn", true)

func _on_button_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true)
