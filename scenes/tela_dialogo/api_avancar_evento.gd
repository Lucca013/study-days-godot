extends "res://scenes/scripts/api.gd"

signal apiRetorno

func _ready() -> void:
	super()
	
func avancarEvento() -> void:
	url = baseUrl + "jogo/avancarEvento/" + str(Save.idJogoAtual)
	requisicaoPost(null)

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	var retorno : Variant = json.parse_string(string)
	print(retorno)
	apiRetorno.emit(retorno)	
