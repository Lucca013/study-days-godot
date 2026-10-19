class_name botaoMelhoria extends botaoEstilizado

var status : String
var idMelhoria : int
var descricaoMelhoria : String
var styleUnico : StyleBox 
signal botaoPressionado(idMelhoria : int)

func _ready() -> void:
	super()
	
	styleUnico = get_theme_stylebox("normal").duplicate()
	add_theme_stylebox_override("normal", styleUnico)
	
	pressed.connect(_on_pressed)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	adicionarMargemAltura() ## só adiciona uma margem de 20 px na dimensão Y
	alterarEstilo() ## muda o estilo de acordo com o status da melhoria 
	
	await get_tree().process_frame
	pivot_offset = size / 2
	
func _on_pressed() -> void:
	print("Botão pressionado!")
	botaoPressionado.emit(idMelhoria, descricaoMelhoria, text, status) # "text" é nome da melhoria 

func adicionarMargemAltura() -> void:
	var tamanhoParente : Vector2 = get_parent_area_size()
	var tamanhoFilho : Vector2

	tamanhoFilho.y = tamanhoParente.y - 20
	
	custom_minimum_size.y = tamanhoFilho.y
	custom_maximum_size.y = tamanhoFilho.y

func alterarEstilo() -> void:
	match (status): 
		"BLOQUEADO": 
			styleUnico.bg_color = Color(0.727, 0.179, 0.186, 1.0)
			hoverStylebox.bg_color = Color(0.727, 0.179, 0.186, 1.0)
		"DISPONIVEL":
			styleUnico.bg_color = Color(0.76, 0.662, 0.228, 1.0)
			hoverStylebox.bg_color = Color(0.76, 0.662, 0.228, 1.0)
		"ADQUIRIDO":
			styleUnico.bg_color = Color(0.51, 0.761, 0.388)
			hoverStylebox.bg_color = Color(0.51, 0.761, 0.388)

func _on_mouse_entered() -> void:
	if tween:tween.kill()
	
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_parallel(true)
	
	tween.tween_property(self, "scale", Vector2(1.04,1.04), 0.5)
	tween.tween_property(hoverStylebox, "border_width_left", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_right", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_top", 4, 0.5)
	tween.tween_property(hoverStylebox, "border_width_bottom", 4, 0.5)
