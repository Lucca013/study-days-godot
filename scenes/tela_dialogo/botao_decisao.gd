class_name botaoDecisao extends botaoEstilizado

@export var textoBotao : String 
@export var idEscolha : String 
var styleBotao : StyleBoxFlat
signal escolhaPressionada(idEscolha : String)

func _ready() -> void:
	super() ## Ele só inicializa umas variáveis referentes a posição do botão, para as animações
	text = textoBotao 
	pressed.connect(_button_pressed)
	
	estilizarBotao()
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	adicionarMargemAltura()
	
	pivot_offset = size/2
	
func estilizarBotao() -> void:
	styleBotao = get_theme_stylebox("normal").duplicate()
	add_theme_stylebox_override("normal", styleBotao)
	
	add_theme_color_override("font_color", Color.WHITE)
	add_theme_font_size_override("font_size", 32)
	styleBotao.bg_color = Color(0.51, 0.761, 0.388)
	hoverStylebox.bg_color = Color(0.51, 0.761, 0.388)
	hoverStylebox.bg_color = Color(0.208, 0.588, 0.0)

func _button_pressed() -> void:
	escolhaPressionada.emit(idEscolha)

func adicionarMargemAltura() -> void:
	var tamanhoParente : Vector2 = get_parent_area_size()
	var tamanhoFilho : Vector2

	tamanhoFilho.y = tamanhoParente.y - 20
	
	custom_minimum_size.y = tamanhoFilho.y
	custom_maximum_size.y = tamanhoFilho.y
