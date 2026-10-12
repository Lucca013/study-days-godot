extends Control
	
func _on_ranking_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_ranking/tela_ranking.tscn", false)

func _on_sair_pressed() -> void:
	Global.game_controller.sairJogo()

func _on_carregar_jogo_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_jogos_salvos/tela_jogo_salvos.tscn", false)

func _on_novo_jogo_pressed() -> void:
	$ApiCriarJogo.requisicaoPost(null)

func _on_api_criar_jogo_api_retorno(retorno: Variant) -> void:
	if(retorno != null):
		Save.idJogoAtual = retorno["id"]
		Global.game_controller.mudarTela("res://scenes/tela_dialogo/tela_dialogo.tscn", false)
	else:
		print(retorno)
