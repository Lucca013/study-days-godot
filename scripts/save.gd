extends Node

var pontoMelhoria : int 
var pontuacaoAtual : int  
var idJogoAtual: int 
var listaMelhoriasDesbloquedas : Variant

signal atualizarPontuacaoMelhoria 
	
func gastarPontoMelhoria(valor : int) -> bool:
	if(valor > pontoMelhoria):
		return false
	else: 
		return true 
