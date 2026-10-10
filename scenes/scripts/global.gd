extends Node

var nomeUsuario: String = "null"
var idUsuario: int = 0
var idJogoAtual: int = 0
var game_controller : GameController

func wait(segundos: float) -> Signal:
	return get_tree().create_timer(segundos).timeout
