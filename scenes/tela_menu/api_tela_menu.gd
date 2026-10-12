extends "res://scenes/scripts/api.gd"

signal dadosTelaMenuRecebidos(retorno : Variant)

func _ready() -> void:
	super()
	url = ("http://localhost:8080/jogo/listar/usuario/" + str(Global.idUsuario))

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var retorno : Variant = body.get_string_from_utf8()
	var dados : Variant = json.parse_string(retorno)
	dadosTelaMenuRecebidos.emit(dados)
