extends HBoxContainer

var _button_grass: Button
var _button_fire: Button
var _button_path: Button

const PlayerControl := preload("res://script/PlayerControl.gd")

var _ref_PlayerControl: PlayerControl

var _GroupName := preload("res://script/library/GroupName.gd").new()


func _ready():
	_button_grass = get_node("Grass")
	_button_fire = get_node("Fire")
	_button_path = get_node("Path")

	_button_grass.connect("pressed", self, "_grass_pressed")
	_button_fire.connect("pressed", self, "_fire_pressed")
	_button_path.connect("pressed", self, "_path_pressed")


func _grass_pressed():
	_ref_PlayerControl.tile_type_selected(_GroupName.TILE_GRASS)


func _fire_pressed():
	_ref_PlayerControl.tile_type_selected(_GroupName.TILE_FIRE)


func _path_pressed():
	_ref_PlayerControl.tile_type_selected(_GroupName.PATH)
