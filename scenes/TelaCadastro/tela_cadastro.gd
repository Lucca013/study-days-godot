extends Control

func _ready():
	$MensagemErro.hide()

func _on_cadastro_pressed() -> void:
	var usuario = $Panel/VBoxContainer/UsuarioInput.text
	var senha = $Panel/VBoxContainer/SenhaInput.text
	var senha2 = $Panel/VBoxContainer/SenhaInput2.text
	
	usuario = usuario.trim_suffix(" ")
	senha = senha.trim_suffix(" ")
	senha2 = senha2.trim_suffix(" ")
	
	if(usuario == "" || senha == "" || senha2 == ""):
		$MensagemErro.mostrarMensagem("Preencha todos os campos!")
		return
	
	if(senha != senha2):
		$MensagemErro.mostrarMensagem("Digite a mesma senha nos dois campos!")
		return
		
	var dados = { 
		"nome" = usuario,
		"senhaHash" = senha
	}
	$ApiTelaCadastro.requisicaoPost(dados) 

func _on_login_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/TelaLogin/tela_login.tscn", true)

func _on_api_retorno(retorno, response_code) -> void:
	if(response_code == 201):
		print(retorno)
		Global.game_controller.mudarTela("res://scenes/TelaLogin/tela_login.tscn", true)
	else:
		print(response_code)
		print(retorno)
