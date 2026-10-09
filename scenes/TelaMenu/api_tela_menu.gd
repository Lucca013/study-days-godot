extends "res://scenes/scripts/api.gd"

signal dadosTelaMenuRecebidos(retorno)

func _ready():
	super()
	url = ("http://localhost:8080/jogo/listar/usuario/" + str(Global.idUsuario))

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray):
	var retorno = body.get_string_from_utf8()
	var dados = json.parse_string(retorno)
	dadosTelaMenuRecebidos.emit(dados)
