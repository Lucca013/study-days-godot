extends Control

var cenasPersonagem : Dictionary = { 
	"Protagonista" : preload("res://scenes/personagens/protagonista.tscn")
}

var personagensAtivos : Dictionary = {}

func _ready() -> void:
	pass # Replace with function body.

func receberDialogo(dialogo : Variant) -> void:
	var personagem : PersonagemBase
	var nomePersonagem : String 
	var movimentacao : String
	nomePersonagem = dialogo["nomePersonagem"]
	movimentacao = dialogo["movimentacaoPersonagem"]
	personagem = obterPersonagem(nomePersonagem)
	moverPersonagem(personagem, movimentacao)
	
func obterPersonagem(nomePersonagem : String) -> PersonagemBase: 
	if(personagensAtivos.has(nomePersonagem)):
		return personagensAtivos[nomePersonagem]
 	
	var personagem : PersonagemBase = cenasPersonagem[nomePersonagem].instantiate()
	self.add_child(personagem)
	personagensAtivos[nomePersonagem] = personagem
	return personagem

func moverPersonagem(personagem : PersonagemBase, movimentacao : String) -> void:
	match (movimentacao):
		"PARADO": 
			pass
		"ENTRAR_DIREITA":
			personagem.position = $Posicao/FarRight.position
			personagem.snap($Posicao/Right)
		"ENTRAR_ESQUERDA":
			personagem.position = $Posicao/FarLeft.position
			personagem.snap($Posicao/Left)
		"SAIR_DIREITA":
			personagem.snap($Posicao/FarRight)
		"SAIR_ESQUERDA":
			personagem.snap($Posicao/FarLeft)
		"IR_CENTRO":
			personagem.move($Posicao/Center)
		"IR_ESQUERDA":
			personagem.move($Posicao/Left)
		"IR_DIREITA":
			personagem.move($Posicao/Right)
		"FLIP": 
			personagem.flip_h = !personagem.flip_h
