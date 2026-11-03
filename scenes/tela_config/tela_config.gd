extends Control

@export var fullscreen_check : CheckButton
@export var borderless_check : CheckButton 
@export var resolutions : OptionButton

var resolutions_values := [
		Vector2i(1920, 1080),
		Vector2i(1600, 900),
		Vector2i(1280, 720),
		Vector2i(640, 360)
	]

func _ready() -> void:
	for res : Vector2i in resolutions_values:
		resolutions.add_item(str(res.x) + "x" +str(res.y))

	carregar_configuracoes_atuais()

func carregar_configuracoes_atuais() -> void:
	var mode := DisplayServer.window_get_mode()
	fullscreen_check.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless_check.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	
	var window_size := DisplayServer.window_get_size()
	for i in range(resolutions_values.size()):
		if resolutions_values[i] == window_size:
			resolutions.select(i)
			break

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

func _on_resolutions_item_selected(index: int) -> void:
	var text : String = resolutions.get_item_text(index)
	var parts : PackedStringArray = text.split("x")
	if parts.size() == 2:
		DisplayServer.window_set_size(Vector2i(int(parts[0]), int(parts[1])))
	ConfigController.video_settings["resolution"] = Vector2i(int(parts[0]), int(parts[1]))
