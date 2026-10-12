extends "res://scenes/scripts/api.gd"

signal dadosTelaRankingRecebidos(retorno : Variant)

func _ready() -> void:
	super()
	url = "http://localhost:8080/RecordePessoal/listar"

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var retorno : Variant = body.get_string_from_utf8()
	var dados : Variant = json.parse_string(retorno)
	dadosTelaRankingRecebidos.emit(dados)
