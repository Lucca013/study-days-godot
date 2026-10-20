extends Control
var cenaCaixaDialogo : PackedScene = preload("res://scenes/tela_dialogo/caixa_dialogo.tscn")
var caixaEscolha : PackedScene = preload("res://scenes/tela_dialogo/caixa_escolha.tscn")
var posicaoDialogo : int = 0
var dialogo : Variant 
var decisao : Variant 
signal cliqueEmTelaVazia(event : InputEvent)

func _ready() -> void:
	$ApiJogo.listarJogoEspecifico()
	print($ApiJogo.url)
	
	$MelhoriaLabel.mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	$PontuacaoLabel.mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	$Container.mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	$Personagem.mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	$Background.mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE

func handle_api_jogo_retorno(retorno: Variant) -> void:
	dialogo = retorno["eventoAtual"]["dialogos"]
	Save.pontuacaoAtual = retorno["pontuacaoAtual"]
	Save.pontoMelhoria = retorno["pontoMelhoria"]
	Save.listaMelhoriasDesbloquedas = retorno["listaMelhorias"]
	
	$MelhoriaLabel.text = "Pontos Melhoria: "+str(int(retorno["pontoMelhoria"]))
	$PontuacaoLabel.text = "Pontuação: " + str(int(retorno["pontuacaoAtual"]))
	montarDialogo()

func montarDialogo() -> void:
	if(posicaoDialogo >= dialogo.size()): ## Quando acabar o diálogo, puxa as escolhas do evento
		$ApiDecisao.listarDecisoesValidas()
		return
	
	var dialogoAtual : Variant = dialogo[posicaoDialogo]
	var caixaDialogoAtual: CaixaDialogo = cenaCaixaDialogo.instantiate()
	
	$Personagem.receberDialogo(dialogoAtual)	
	caixaDialogoAtual.nomePersonagem = dialogoAtual["nomePersonagem"]
	caixaDialogoAtual.dialogo = dialogoAtual["fala"]
	
	self.add_child(caixaDialogoAtual)
	await caixaDialogoAtual.tree_exited
	
	posicaoDialogo += 1
	montarDialogo() ## Monta a próxima caixa de diálogo em loop

func handle_api_decisao_retorno(retorno : Variant ) -> void:
	var caixaDialogoDecisao : CaixaDialogo = cenaCaixaDialogo.instantiate()
	caixaDialogoDecisao.nomePersonagem = ""
	caixaDialogoDecisao.dialogo = "O que eu deveria fazer?"
	self.add_child(caixaDialogoDecisao) 
	montarDecisoes(retorno)
	
func montarDecisoes(dados : Variant) -> void:
	var escolhasAtuais : caixaEscolha = caixaEscolha.instantiate()
	escolhasAtuais.dados = dados
	escolhasAtuais.escolhaPressionada.connect(handle_escolha_pressionada)
	$Container.add_child(escolhasAtuais)

func handle_escolha_pressionada(idEscolha : String) -> void:
	print("Escolha pressionada: " + idEscolha)
	$ApiConsequencia.idEscolha = str(int(idEscolha))
	$ApiConsequencia.processarEscolha()
	print("Chamando $ApiConsequencia, URL: " + str($ApiConsequencia.url))

func handle_api_consequencia_retorno(retorno : Variant) -> void:
	print("CONSEQUENCIA DO EVENTO COM DECISAO")
	print("IDJOGOATUAL: " + str(Save.idJogoAtual))
	print(retorno)
	
	for filho in get_children():
		if filho is CaixaDialogo:
			filho.queue_free()
	
	var caixaDialogoConsequencia : CaixaDialogo = cenaCaixaDialogo.instantiate()
	caixaDialogoConsequencia.nomePersonagem = ""
	caixaDialogoConsequencia.dialogo = retorno["descricao"]
	self.add_child(caixaDialogoConsequencia) 

	$PontuacaoLabel.atualizarPontuacaoInicio(int(retorno["valorPontuacao"]))
	Save.pontuacaoAtual = retorno["pontuacaoAtual"]
	
	await caixaDialogoConsequencia.tree_exited
	
	$ApiAvancarEvento.avancarEvento()
	print("Chamando $ApiAvancarEvento, URL: " + str($ApiAvancarEvento.url))

func _handle_api_avancar_evento(retorno : Variant) -> void:
	if(retorno != null):
		posicaoDialogo = 0
		$ApiJogo.listarJogoEspecifico()
		print("Chamando $ApiJogo, URL: " + str($ApiJogo.url))
	else:
		self.queue_free()
		# Aqui deveria chamar alguma função especial para fazer a tela de final de um save 
		# me refiro a um pop up ou coisa assim mesmo 
	
func _handle_menu_botao() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true) 

func handle_melhoria_botao() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_melhoria/tela_melhoria.tscn", false)

func _unhandled_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton) and (event.pressed == true):
		cliqueEmTelaVazia.emit(event)
		print("Clique em tela vazia!")
