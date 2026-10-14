extends Control
var listaMelhoria : Variant 
var botaoMelhoriaCena : PackedScene = preload("res://scenes/tela_melhoria/botao_melhoria.tscn")

func _ready() -> void:
	$ApiMelhoria.requisicaoGet()

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
	if (ordem == 0):
		$CenterContainer/ArvoreMelhoria/PrimeiraColuna.add_child(botaoMelhoria)
	if (ordem == 1):
		$CenterContainer/ArvoreMelhoria/SegundaColuna.add_child(botaoMelhoria)
	if (ordem == 2):
		$CenterContainer/ArvoreMelhoria/TerceiraColuna.add_child(botaoMelhoria)	

func handle_comprar_melhoria(idMelhoria : int) -> void:
	$ApiLiberarMelhoria.liberarMelhoria(idMelhoria)
	print($ApiLiberarMelhoria.url)

func handle_api_liberar_melhoria_retorno(retorno : Variant, response_code : int) -> void:
	if(response_code == 200):
		print(retorno)
		return
	if(response_code == 409):
		print("Melhoria já adquirida ou bloqueada!")
		return
