extends Control
var listaMelhoria : Variant 

func _ready() -> void:
	$ApiMelhoria.exibirArvoreMelhoria()
	$PontosMelhoriaLabel.text = "Pontos de Melhoria Disponíveis: " + str(Save.pontoMelhoria)
	$MensagemErro.hide()

func handle_api_melhoria_retorno(retorno : Variant) -> void:
	listaMelhoria = retorno
	montarTelaMelhoria()
	
func montarTelaMelhoria() -> void:
	var idMelhoria : int
	var texto : String
	var ordem : int
	var status : String
	var descricao : String
	for linha : Variant in listaMelhoria:
		idMelhoria = linha["id"]
		texto = linha["nome"]
		ordem = linha["ordem"]
		status = linha["status"]
		descricao = linha["descricao"]
		adicionarBotao(idMelhoria, texto, ordem, status, descricao) 
		
func adicionarBotao(idMelhoria : int, textoBotao : String, ordem : int, status : String, descricao : String) -> void: 
	var botaoMelhoria : Node = botaoMelhoria.new()
	botaoMelhoria.idMelhoria = idMelhoria
	botaoMelhoria.text = textoBotao
	botaoMelhoria.status = status
	botaoMelhoria.descricaoMelhoria = descricao
	botaoMelhoria.botaoPressionado.connect(handle_comprar_melhoria)
	match ordem:
		0:
			$ArvoreMelhoria/PrimeiraColuna.add_child(botaoMelhoria)
		1:
			$ArvoreMelhoria/SegundaColuna.add_child(botaoMelhoria)
		2:
			$ArvoreMelhoria/TerceiraColuna.add_child(botaoMelhoria)	
		3:
			$ArvoreMelhoria/QuartaColuna.add_child(botaoMelhoria)	
		4:
			$ArvoreMelhoria/QuintaColuna.add_child(botaoMelhoria)	

func handle_comprar_melhoria(idMelhoria : int, descricaoMelhoria : String, text : String, status : String) -> void:
	$PopUpMelhoria.montar_pop_up(idMelhoria, descricaoMelhoria, text, status)

func handle_api_liberar_melhoria_retorno(retorno : Variant, response_code : int) -> void:
	if(response_code == 200):
		print(retorno)
		$PopUpMelhoria.mostrar_retorno(retorno, true)
		return
	if(response_code == 409):
		print("Melhoria já adquirida ou bloqueada!")
		$MensagemErro.mostrarMensagem("Erro! Não pode comprar essa melhoria ainda!")
		$PopUpMelhoria.mostrar_retorno(retorno, false)
		return

func handle_menu() -> void:
	self.queue_free()

func handle_liberar_melhoria(idMelhoria: int) -> void:
	$ApiLiberarMelhoria.liberarMelhoria(idMelhoria)
