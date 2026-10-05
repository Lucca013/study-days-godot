extends "res://scenes/api.gd"

signal usuarioCadastrado

func _ready():
	super()
	url = "http://localhost:8080/usuario/cadastrar"

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray):
	var string: String = body.get_string_from_utf8()
	var retorno = json.parse_string(string)
	print(retorno)
	usuarioCadastrado.emit(retorno)	
