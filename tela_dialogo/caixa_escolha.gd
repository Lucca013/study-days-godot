class_name caixaEscolha extends Control
@export var dados : Variant 
var posicao : int = 0
signal escolhaPressionada(idEscolha : String)

func _ready() -> void:
	var quantidadeBotoes : int = dados.size() 
	if(quantidadeBotoes >= 4):
		$GridContainer.columns = 2 
	else:
		$GridContainer.columns = 1
	montarEscolhas()

func montarEscolhas() -> void:
	for decisaoAtual : Variant in dados:
		var botao: botaoDecisao = botaoDecisao.new()

		botao.textoBotao = decisaoAtual["descricao"]
		botao.idEscolha = str(decisaoAtual["id"])
		botao.escolhaPressionada.connect(_on_escolha_pressionada)
		$GridContainer.add_child(botao)
	
func _on_escolha_pressionada(idEscolha: String) -> void:
	escolhaPressionada.emit(idEscolha)
	self.queue_free()
