extends Node

var pontoMelhoria : int
var pontuacaoAtual : int 
var idJogoAtual: int = 1

func aumentarPontuacao(valor : int) -> void:
	pontuacaoAtual += valor 
	print("Pontuação aumentada! Pontuação atual: " +str(pontuacaoAtual))
	
func gastarPontoMelhoria(valor : int) -> bool:
	if(valor > pontoMelhoria):
		return false
	else: 
		return true 
