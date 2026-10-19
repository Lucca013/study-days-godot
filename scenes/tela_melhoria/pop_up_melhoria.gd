extends Control

var idMelhoria : int 
signal liberarMelhoria(idMelhoria : int)
var tween : Tween

func _ready() -> void:
	hide()
	%Check.hide()
	%Mark.hide()
	%ContainerMelhoriaTexto.pivot_offset = size/2
	%ContainerLiberarMelhoria.pivot_offset = size/2
	$Panel.scale = Vector2.ZERO
	$Panel.pivot_offset = size/2
	
func montar_pop_up(idMelhoriaBotao : int, descricaoMelhoria : String, nomeMelhoria : String, status : String) -> void:
	idMelhoria = idMelhoriaBotao
	%TituloMelhoria.text = nomeMelhoria
	%TituloMelhoriaLiberada.text = nomeMelhoria
	%DescricaoMelhoria.text = descricaoMelhoria
	if(status == "LIBERADO"):
		$Panel/ContainerMelhoriaTexto/ComprarMelhoria.hide()
	else:
		$Panel/ContainerMelhoriaTexto/ComprarMelhoria.hide()
	$Panel/ContainerMelhoriaTexto.show()
	$Panel/ContainerLiberarMelhoria.hide()
	%Check.hide()
	%Mark.hide()
	show()
	
	if tween:tween.kill()
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property($Panel, "scale", Vector2(1.0, 1.0), 0.2)

func handle_fechar() -> void:
	hide()

func handle_comprar_melhoria() -> void:
	liberarMelhoria.emit(idMelhoria)
	
func mostrar_retorno(retorno : Variant, sucesso : bool) -> void:
	if(sucesso):
		%DescricaoLiberar.text = "Melhoria liberada com sucesso!"
		%Check.show()
	else:
		%DescricaoLiberar.text = "Erro! Você não pode liberar essa melhoria ainda!"
		%Mark.show()
	
	if tween:tween.kill()
	tween = get_tree().create_tween()
	
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	
	tween.tween_property(%ContainerMelhoriaTexto, "modulate:a", 0, 0.2)
	%ContainerLiberarMelhoria.modulate.a = 0
	%ContainerLiberarMelhoria.show()
	tween.tween_property(%ContainerLiberarMelhoria, "modulate:a", 1, 0.6)

func handle_fechar_liberar() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_melhoria/tela_melhoria.tscn", true)
