extends Control

var usuario : String
var senha : String
	
func _ready():
	$MensagemErro.hide()

func _on_login_pressed():
	senha = $Panel/VBoxContainer/SenhaInput.text
	usuario = $Panel/VBoxContainer/UsuarioInput.text
	
	senha = senha.trim_suffix(" ")
	usuario = usuario.trim_suffix(" ")
	
	print("Botão de Login pressionado!")
	print("Usuario" + usuario)
	print("Senha" + senha)
	
	var dados = {
		"nome" : usuario,
		"senhaHash": senha
	}
	$ApiTelaLogin.requisicaoPost(dados) 

func _on_api_tela_login_api_retorno(retorno):
	if(retorno == null):
		print("Login com erro!")
		$MensagemErro.mostrarMensagem("Usuário inválido!")
	else:
		Global.nomeUsuario = retorno["nome"]
		Global.idUsuario = retorno["id"]
		Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true)
		print("Login bem sucedido!")
		print("Nome salvo do autoload é "+ Global.nomeUsuario)
		print("ID de usuario salvo no autoload é: " + str(Global.idUsuario))
