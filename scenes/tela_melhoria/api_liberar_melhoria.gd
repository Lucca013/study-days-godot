extends "res://scenes/scripts/api.gd"

signal apiRetorno
var idMelhoria : int

func _ready() -> void:
	super()
	
func liberarMelhoria(id : int) -> void: 
	idMelhoria = id
	url = baseUrl + "melhoria/liberar/" + str(idMelhoria) + "/jogo/" + str(Save.idJogoAtual)
	requisicaoPost(null)

func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	var string: String = body.get_string_from_utf8()
	var retorno : Variant = json.parse_string(string)
	apiRetorno.emit(retorno, response_code)	
