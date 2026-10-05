extends Control
	
var usuario : String
var senha : String
	
## até dá para adicionar signals para quando os inputs são escritos, hm
## daria para testar possivelmente já testar por erros depois do usuário digitar?
	
func _on_login_pressed():
	senha = $Panel/VBoxContainer/SenhaInput.text
	usuario = $Panel/VBoxContainer/UsuarioInput.text
	
	print("Botão de Login pressionado!")
	print("Usuario" + usuario)
	print("Senha" + senha)
	
	var dados = {
		"nome" : usuario,
		"senhaHash": senha
	}
	$ApiTelaLogin.requisicaoPost(dados)

	## aqui já poderia ter validações de: 
	## 1 - se ta vazio os campos (deve ter um .trim ne?) 
	## 2 - n tinha realmente validações de senha/usuario, hm...
