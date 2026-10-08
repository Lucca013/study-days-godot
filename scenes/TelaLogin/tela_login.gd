extends Control

signal loginSucedido 
var usuario : String
var senha : String
	
func _ready():
	$ErroLabel.hide()

func _on_login_pressed():
	senha = $Panel/VBoxContainer/SenhaInput.text
	usuario = $Panel/VBoxContainer/UsuarioInput.text
	
	print("Botão de Login pressionado!")
	print("Usuario" + usuario)
	print("Senha" + senha)
	
	## Tem bastante coisinha que eu poderia e deveria fazer aqui. Validação de erros.
	## Se os campos estão vazios, tirar o espaço deles, etc etc
	
	var dados = {
		"nome" : usuario,
		"senhaHash": senha
	}
	$ApiTelaLogin.requisicaoPost(dados)

func _on_api_tela_login_api_retorno(retorno):
	if(retorno == null):
		print("Login com erro!")
		$ErroLabel.show()
		## ter alguma animaçãozinha seria nice, also: Sumir com o tempo 
	else:
		loginSucedido.emit()
		print("Login bem sucedido!")
