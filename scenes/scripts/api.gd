@abstract
extends Node
var json = JSON.new()
var req = HTTPRequest.new()
var url

func _ready():
	add_child(req)
	req.request_completed.connect(received)

func requisicaoGet():
	var erro = req.request(url)
	if erro != OK:
		print("Erro ao enviar Requisição GET: "+erro)
	else:
		print("Requisição GET enviada com sucesso!")
	
func requisicaoPost(dados):
	dados = json.stringify(dados)
	
	var erro = 	req.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, dados)
	if erro != OK:
		print("Erro ao enviar Requisição POST: " + erro) 
	else:
		print("Requisição Post enviada com sucesso!")
	
func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray):
	pass 
