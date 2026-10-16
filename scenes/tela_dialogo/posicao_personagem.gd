extends Control

@onready var far_left: Marker2D = $FarLeft
@onready var left: Marker2D = $Left
@onready var center: Marker2D = $Center
@onready var right: Marker2D = $Right
@onready var far_right: Marker2D = $FarRight

func _ready() -> void:
	posicionar_markers()

func posicionar_markers() -> void:
	var largura := get_parent_area_size().x
	var altura := get_parent_area_size().y

	var y := altura * 0.75

	far_left.position = Vector2(largura * -0.10, y)
	left.position = Vector2(largura * 0.20, y)
	center.position = Vector2(largura * 0.50, y)
	right.position = Vector2(largura * 0.80, y)
	far_right.position = Vector2(largura * 1.10, y)
	
