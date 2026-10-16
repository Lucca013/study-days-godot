extends Control
var cenaCaixaDialogo : PackedScene = preload("res://scenes/tela_dialogo/caixa_dialogo.tscn")
var caixaEscolha : PackedScene = preload("res://scenes/tela_dialogo/caixa_escolha.tscn")
var posicaoDialogo : int = 0
var dialogo : Variant 
var decisao : Variant 

func _ready() -> void:
	$ApiJogo.requisicaoGet()

func handle_api_jogo_retorno(retorno: Variant) -> void:
	dialogo = retorno["eventoAtual"]["dialogos"]
	Save.pontuacaoAtual = retorno["pontuacaoAtual"]
	Save.pontoMelhoria = retorno["pontoMelhoria"]
	Save.listaMelhoriasDesbloquedas = retorno["listaMelhorias"]
	
	$MelhoriaLabel.text = "Pontos Melhoria: "+str(retorno["pontoMelhoria"])
	$PontuacaoLabel.text = "Pontuação: "+str(retorno["pontuacaoAtual"])
	montarDialogo()

func montarDialogo() -> void:
	if(posicaoDialogo >= dialogo.size()): ## Quando acabar o diálogo, puxa as escolhas do evento
		$ApiDecisao.requisicaoGet()
		print($ApiDecisao.url)
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
	$CenterContainer.add_child(escolhasAtuais)

func handle_escolha_pressionada(idEscolha : String) -> void:
	print("Escolha pressionada: " + idEscolha)
	$ApiConsequencia.idEscolha = str(int(idEscolha))
	$ApiConsequencia.processarEscolha()
	print($ApiConsequencia.url)

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

	Save.pontuacaoAtual = retorno["pontuacaoAtual"]
	$PontuacaoLabel.text = "Pontuação: "+str(retorno["pontuacaoAtual"])
	await caixaDialogoConsequencia.tree_exited
	$ApiAvancarEvento.requisicaoPost(null)
	print($ApiAvancarEvento.url)

func _handle_api_avancar_evento(retorno : Variant) -> void:
	posicaoDialogo = 0
	$ApiJogo.requisicaoGet()
	print($ApiJogo.url)
	
func _handle_menu_botao() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true) 

func handle_melhoria_botao() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_melhoria/tela_melhoria.tscn", false)
