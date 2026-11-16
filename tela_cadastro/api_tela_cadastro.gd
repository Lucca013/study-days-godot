extends "res://scenes/scripts/api.gd"

signal apiRetorno 

func _ready() -> void:
	super()

func cadastrarUsuario(dados : Variant) -> void:
	url = baseUrl + "usuario/cadastrar"
	requisicaoPost(dados)

func received(_result: int, response_code: int, _header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	var retorno : Variant = json.parse_string(string)
	print(retorno)
	apiRetorno.emit(retorno, response_code)	
