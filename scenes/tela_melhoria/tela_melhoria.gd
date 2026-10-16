extends Control
var listaMelhoria : Variant 

func _ready() -> void:
	$ApiMelhoria.requisicaoGet()
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
	for linha : Variant in listaMelhoria:
		idMelhoria = linha["id"]
		texto = linha["nome"]
		ordem = linha["ordem"]
		status = linha["status"]
		adicionarBotao(idMelhoria, texto, ordem, status) 
		
func adicionarBotao(idMelhoria : int, textoBotao : String, ordem : int, status : String) -> void: 
	var botaoMelhoria : Node = botaoMelhoria.new()
	botaoMelhoria.idMelhoria = idMelhoria
	botaoMelhoria.text = textoBotao
	botaoMelhoria.status = status
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

func handle_comprar_melhoria(idMelhoria : int) -> void:
	$ApiLiberarMelhoria.liberarMelhoria(idMelhoria)
	print($ApiLiberarMelhoria.url)

func handle_api_liberar_melhoria_retorno(retorno : Variant, response_code : int) -> void:
	if(response_code == 200):
		print(retorno)
		return
	if(response_code == 409):
		print("Melhoria já adquirida ou bloqueada!")
		$MensagemErro.mostrarMensagem("Erro! Não pode comprar essa melhoria ainda!")
		# definitivamente especificar mais depois isso aqui
		return

func handle_menu() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_dialogo/tela_dialogo.tscn", true)
