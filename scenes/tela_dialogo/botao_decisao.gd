class_name botaoDecisao extends botaoEstilizado

@export var textoBotao : String 
@export var idEscolha : String 

signal escolhaPressionada(idEscolha : String)

func _ready() -> void:
	super() ## Ele só inicializa umas variáveis referentes a posição do botão, para as animações
	text = textoBotao 
	pressed.connect(_button_pressed)
	
func _button_pressed() -> void:
	escolhaPressionada.emit(idEscolha)
