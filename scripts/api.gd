@abstract
extends Node
var json : JSON = JSON.new()
var req : HTTPRequest = HTTPRequest.new()
var url : String
var baseUrl : String = "http://localhost:8080/"

func _ready() -> void:
	add_child(req)
	req.request_completed.connect(received)

func requisicaoGet() -> void:
	var erro : Error = req.request(url)
	if erro != OK:
		print("Erro ao enviar Requisição GET: "+str(erro))
	
func requisicaoPost(dados : Variant) -> void:
	dados = json.stringify(dados)
	
	var erro : Error = 	req.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, dados)
	if erro != OK:
		print("Erro ao enviar Requisição POST: " + str(erro)) 
	
func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray) -> void:
	pass 
