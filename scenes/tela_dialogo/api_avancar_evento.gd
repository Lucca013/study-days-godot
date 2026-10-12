extends "res://scenes/scripts/api.gd"

signal apiRetorno

func _ready() -> void:
	super()
	url = "http://localhost:8080/jogo/avancarEvento/" + str(Save.idJogoAtual)
	
func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	var retorno : Variant = json.parse_string(string)
	print(retorno)
	apiRetorno.emit(retorno)	
