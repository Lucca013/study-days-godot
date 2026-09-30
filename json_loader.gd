extends Node

func lerJson():
	var file = FileAccess.open("res://assets/texts/evento.json", FileAccess.READ)
	var json = file.get_as_text()
	var saved_data = JSON.parse_string(json)
	print(saved_data[1]["titulo"])
	file.close()

## considerações:
## 1 - res:: vira read-only depois de ser exportado, mas isso basicamente não é um problema
## na maior parte dos casos 
## 2 - print(saved_data) vai dar todo o json
## 3 - print(saved_data[1]) vai retornar todas as informações com id 1 
## (ele deve pegar pela posição do campo no json, eu imagino) 	
