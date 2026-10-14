extends Node

var pontoMelhoria : int = 0
var pontuacaoAtual : int = 0 
var idJogoAtual: int = 1
var listaMelhoriasDesbloquedas : Variant
	
func gastarPontoMelhoria(valor : int) -> bool:
	if(valor > pontoMelhoria):
		return false
	else: 
		return true 
