extends "res://scenes/scripts/api.gd"

signal apiRetorno

func _ready() -> void:
	super()

func obterDica() -> void:
	url = baseUrl + "jogo/" + str(Save.idJogoAtual) + "/dicas"
	requisicaoGet()

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	print(string)
	apiRetorno.emit(string, response_code)	
