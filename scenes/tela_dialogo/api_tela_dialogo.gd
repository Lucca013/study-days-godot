extends "res://scenes/scripts/api.gd"

signal apiRetorno

func _ready():
	super()
	url = "http://localhost:8080/jogo/listar/" + str(Global.idJogo)

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray):
	var string: String = body.get_string_from_utf8()
	var retorno = json.parse_string(string)
	print(retorno)
	apiRetorno.emit(retorno)	
