extends Node

var config : ConfigFile = ConfigFile.new()
const caminhoConfig = "user://settings.ini"

var video_settings := {
	"fullscreen": false,
	"borderless": false,
	"resolution": Vector2i(1280, 720)
}

func _ready() -> void:
	load_settings()
	apply_settings()

func save_settings() -> void:
	var config : ConfigFile = ConfigFile.new()
	
	for key : String in video_settings:
		config.set_value("video", key, video_settings[key])
	
	config.save(caminhoConfig)

func load_settings() -> void:
	var config : ConfigFile = ConfigFile.new()
	var err := config.load(caminhoConfig)
	if err != OK:
		return
	
	for section : String in ["video"]:
		if not config.has_section(section):
			continue
			
		var target_dict : Dictionary = get(section + "_settings") 
		for key : String in target_dict.keys():
			if config.has_section_key(section, key):
				target_dict[key] = config.get_value(section, key)

func apply_settings() -> void:
	var v : Variant = video_settings
	DisplayServer.window_set_mode(
		DisplayServer.WINDOW_MODE_FULLSCREEN if v["fullscreen"] else
		DisplayServer.WINDOW_MODE_WINDOWED
	)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, v["borderless"])
	DisplayServer.window_set_size(v["resolution"])
