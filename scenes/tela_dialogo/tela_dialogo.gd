extends Control
var cenaCaixaDialogo : PackedScene = preload("res://scenes/tela_dialogo/caixa_dialogo.tscn")
var caixaEscolha : PackedScene = preload("res://scenes/tela_dialogo/caixa_escolha.tscn")
var posicaoDialogo : int = 0
var dialogo : Variant 
var decisao : Variant 

func _ready() -> void:
	$ApiDialogo.requisicaoGet()

func _on_dialogo_received(retorno: Variant) -> void:
	dialogo = retorno["eventoAtual"]["dialogos"]
	montarDialogo()

func montarDialogo() -> void:
	if(posicaoDialogo >= dialogo.size()):
		$ApiDecisao.requisicaoGet()
		var caixaDialogoDecisao : CaixaDialogo = cenaCaixaDialogo.instantiate()
		caixaDialogoDecisao.nomePersonagem = ""
		caixaDialogoDecisao.dialogo = "O que eu deveria fazer?"
		self.add_child(caixaDialogoDecisao) 
		return
	
	var dialogoAtual : Variant = dialogo[posicaoDialogo]
	var caixaDialogoAtual: CaixaDialogo = cenaCaixaDialogo.instantiate()
		
	caixaDialogoAtual.nomePersonagem = dialogoAtual["nomePersonagem"]
	caixaDialogoAtual.dialogo = dialogoAtual["fala"]
	
	self.add_child(caixaDialogoAtual)
	await caixaDialogoAtual.tree_exited
	
	posicaoDialogo += 1
	montarDialogo() # A função se repete até o jogador ter visto todos os diálogos do evento 

func _on_decisao_received(retorno : Variant ) -> void:
	montarDecisoes(retorno)
	
func montarDecisoes(dados : Variant) -> void:
	var escolhasAtuais : caixaEscolha = caixaEscolha.instantiate()
	escolhasAtuais.dados = dados
	escolhasAtuais.escolhaPressionada.connect(on_escolha_pressionada)
	$CenterContainer.add_child(escolhasAtuais)

func on_escolha_pressionada(idEscolha : String) -> void:
	print("Escolha pressionada: " +idEscolha)
	$ApiConsequencia.idEscolha = idEscolha 
	$ApiConsequencia.requisicaoGet()

func _on_consequencia_received(retorno : Variant) -> void:
	print("CONSEQUENCIA DO EVENTO COM DECISAO")
	print("IDJOGOATUAL: " + str(Save.idJogoAtual))
	print(retorno)
	
	var caixaDialogoConsequencia : CaixaDialogo = cenaCaixaDialogo.instantiate()
	caixaDialogoConsequencia.nomePersonagem = ""
	caixaDialogoConsequencia.dialogo = retorno["descricao"]
	self.add_child(caixaDialogoConsequencia) 

	Save.aumentarPontuacao(retorno["valorPontuacao"])
	await caixaDialogoConsequencia.tree_exited
	$ApiAvancarEvento.requisicaoPost(null)

func _handle_api_avancar_evento(retorno : Variant) -> void:
	posicaoDialogo = 0
	$ApiDialogo.requisicaoGet()
	
func _handle_menu_botao() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true) 
	
## 1 - Receber o dialogo da API - OK 
## 2 - Chamar a função montarDialogo(dialogo) - OK 
## 3 - Instancia uma nova caixa de dialogo e passa os dados - OK 
## 4 - Cada vez que ela se destrói, monta de novo com o próximo dialogo - OK 
## 5 - Repete até acabar o diálogo, aí mostra as escolhas do evento - OK 
## 6 - Implementar a API para enviar a escolha e o evento para receber a consequência - OK 
## 7 - Avançar Evento até o jogo terminar - OK 
## 8 - Salvar o jogo? 

## também tem o componente do personagem, que eu ainda não montei, mas vou fazer isso alguma hora
