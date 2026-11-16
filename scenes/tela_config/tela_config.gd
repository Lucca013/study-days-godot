extends Control

@export var fullscreen_check : CheckButton
@export var borderless_check : CheckButton 

func _ready() -> void:
	carregar_configuracoes_atuais()

func carregar_configuracoes_atuais() -> void:
	var mode := DisplayServer.window_get_mode()
	fullscreen_check.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless_check.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	
func _on_fullscreen_toggled(enabled: bool) -> void:
	print("função on_fullscreen_toggled chamada!")
	if enabled: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	ConfigController.video_settings["fullscreen"] = enabled

func _on_bordeless_toggled(enabled: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, enabled)
	ConfigController.video_settings["borderless"]

func handle_sair() -> void:
	Global.game_controller.mudarTela("res://scenes/tela_menu/tela_menu.tscn", true)
	ConfigController.save_settings()
