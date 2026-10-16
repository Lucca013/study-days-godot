extends Node

var nomeUsuario: String
var idUsuario: int
var game_controller : GameController

func wait(segundos: float) -> Signal:
	return get_tree().create_timer(segundos).timeout
