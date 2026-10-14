class_name botaoMelhoria extends botaoEstilizado

var status : String
var idMelhoria : int
signal botaoPressionado(idMelhoria : int)

func _ready() -> void:
	super()
	pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	print("Botão pressionado!")
	botaoPressionado.emit(idMelhoria)
