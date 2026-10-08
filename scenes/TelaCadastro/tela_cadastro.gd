extends Control
signal telaLogin

func _on_cadastro_pressed() -> void:
	var usuario = $Panel/VBoxContainer/UsuarioInput.text
	var senha = $Panel/VBoxContainer/SenhaInput.text
	var senha2 = $Panel/VBoxContainer/SenhaInput2.text
	
	var dados = { 
		"nome" = usuario,
		"senhaHash" = senha
	}
	
	if(senha != senha2):
		pass
		## adicionar mensagem de erro aqui eventualmente
	else:
		$ApiTelaCadastro.requisicaoPost(dados) 

func _on_login_pressed() -> void:
	telaLogin.emit()

func _on_api_retorno(retorno) -> void:
	## hmm, eu n tenho certeza como eu verifico erros na requisição
	print(retorno)
	telaLogin.emit()
