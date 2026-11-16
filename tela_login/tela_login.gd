extends Control

var usuario : String
var senha : String
	
func _ready() -> void:
	$MensagemErro.hide()

func _on_login_pressed() -> void:
	senha = $Panel/VBoxContainer/SenhaInput.text
	usuario = $Panel/VBoxContainer/UsuarioInput.text
	
	senha = senha.trim_suffix(" ")
	usuario = usuario.trim_suffix(" ")
	
	var dados : Variant = {
		"nome" : usuario,
		"senhaHash": senha
	}
	$Api.autenticarUsuario(dados) 

func _on_api_tela_login_api_retorno(retorno : Variant) -> void:
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

func _handle_botao_cadastro() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_cadastro/tela_cadastro.tscn", false)


func handle_mostrar_senha(toggled_on: bool) -> void:
	if(toggled_on):
		$Panel/VBoxContainer/SenhaInput.secret = false
	else:
		$Panel/VBoxContainer/SenhaInput.secret = true
