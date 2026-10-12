extends "res://scenes/scripts/api.gd"

signal apiRetorno

func _ready() -> void:
	super()
	# url = "http://localhost:8080/jogo/listar/" + str(Global.idJogoAtual)
	url = "http://localhost:8080/jogo/listar/1"
	# lista jogo especifico 

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	var retorno : Variant = json.parse_string(string)
	print(retorno)
	apiRetorno.emit(retorno)	
