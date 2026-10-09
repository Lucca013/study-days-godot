extends Control
	
func _on_ranking_pressed() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_ranking/tela_ranking.tscn", false)

func _on_sair_pressed() -> void:
	Global.game_controller.sairJogo()

func _on_carregar_jogo_pressed() -> void:
	pass # Replace with function body.

func _on_novo_jogo_pressed() -> void:
	$ApiCriarJogo.requisicaoPost(null)

# hm
# n deveria carregar uma pagina nova logo de cara, deveria?
# carregar deveria ser um pop-up, algo assim
# iniciar um novo jogo ja é ok

# os dois vao precisar de uma classe da API para comunicar com o endpoint de /jogo

func _on_api_menu_listar_jogos_dados_tela_menu_recebidos(retorno: Variant) -> void:
	pass

func _on_api_criar_jogo_api_retorno(retorno: Variant) -> void:
	if(retorno != null):
		Global.idJogoAtual = retorno["id"]
		Global.game_controller.mudarTela("res://scenes/tela_dialogo/tela_dialogo.tscn", false)
	else:
		print(retorno)
