extends Control

func _ready() -> void:
	$TelaLogin.hide()
	$TelaRanking.hide()
	$TelaMenu.hide()
	$TelaCadastro.show()
	$TelaLogin.hide()
	
func _on_login_sucedido() -> void:
	$TelaLogin.hide()
	$TelaMenu.show()
	
func _on_tela_menu_ranking() -> void:
	$TelaMenu.hide()
	$TelaRanking.show()

func _on_tela_menu_sair() -> void:
	get_tree().quit()

func _on_tela_cadastro_tela_login() -> void:
	$TelaCadastro.hide()
	$TelaLogin.show()
	
func _on_tela_ranking_tela_menu() -> void:
	$TelaRanking.hide()
	$TelaMenu.show()
