@abstract
extends Node
var json = JSON.new()
var req = HTTPRequest.new()

var url

func _ready():
	add_child(req)
	req.request_completed.connect(received)

func requisicaoGet():
	req.request(url)
	
func requisicaoPost(dados):
	dados = json.stringify(dados)
	req.request(url, ["Content-Type: application/json"], HTTPClient.METHOD_POST, dados)
	
func received(result: int, response_code: int, header:PackedStringArray, body: PackedByteArray):
	pass 
