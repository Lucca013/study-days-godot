extends Control

signal ranking
signal sair
var tween: Tween

func _on_ranking_pressed() -> void:
	ranking.emit()

func _on_sair_pressed() -> void:
	sair.emit()
