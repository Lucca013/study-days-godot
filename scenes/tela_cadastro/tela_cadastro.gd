extends Control

func _ready() -> void:
	$MensagemErro.hide()

func _on_cadastro_pressed() -> void:
	var usuario : String = $Panel/VBoxContainer/UsuarioInput.text
	var senha : String = $Panel/VBoxContainer/SenhaInput.text
	var senha2 : String= $Panel/VBoxContainer/SenhaInput2.text
	
	usuario = usuario.trim_suffix(" ")
	senha = senha.trim_suffix(" ")
	senha2 = senha2.trim_suffix(" ")
	
	if(usuario == "" || senha == "" || senha2 == ""):
		$MensagemErro.mostrarMensagem("Preencha todos os campos!")
		return
	
	if(senha != senha2):
		$MensagemErro.mostrarMensagem("Digite a mesma senha nos dois campos!")
		return
		
	var dados : Variant = { 
		"nome" = usuario,
		"senhaHash" = senha
	}
	$Api.cadastrarUsuario(dados) 

func _on_login_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_login/tela_login.tscn", true)

func _on_api_retorno(retorno : Variant, response_code : int) -> void:
	if(response_code == 201):
		print(retorno)
		Global.game_controller.mudarTela("res://scenes/tela_login/tela_login.tscn", true)
	else:
		if(response_code == 409):
			$MensagemErro.mostrarMensagem("Nome de usuário já utilizado!")
		else:
			$MensagemErro.mostrarMensagem("Erro! Tente novamente, por favor")

func handle_mostrar_senha(toggled_on: bool) -> void:
	if(toggled_on):
		$Panel/VBoxContainer/SenhaInput.secret = false
		$Panel/VBoxContainer/SenhaInput2.secret = false
	else:
		$Panel/VBoxContainer/SenhaInput.secret = true
		$Panel/VBoxContainer/SenhaInput2.secret = true
