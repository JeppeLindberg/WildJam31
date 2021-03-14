extends Node2D

var _GroupName := preload("res://script/library/GroupName.gd").new()

const CreateObject := preload("res://script/CreateObject.gd")
const EnemyPath := preload("res://script/EnemyPath.gd")
const RemoveObject := preload("res://script/RemoveObject.gd")
const PlayerControl := preload("res://script/PlayerControl.gd")
const PlayingBoard := preload("res://script/PlayingBoard.gd")

var _ref_CreateObject: CreateObject
var _ref_EnemyPath: EnemyPath
var _ref_RemoveObject: RemoveObject
var _ref_PlayerControl: PlayerControl
var _ref_PlayingBoard: PlayingBoard

const Grass := preload("res://sprite/Grass.tscn")
const Fire := preload("res://sprite/Fire.tscn")
const PlannedPath := preload("res://sprite/PlannedPath.tscn")

var _current_tile_type: String
var _painting_path: bool = false
var _path: Array
var _planning_path: Array
var _max_fire_tiles: int = 2

signal update_fire_text(current, max_count)


func _on_MouseControl_tile_click(x: int, y: int):
	if _painting_path:
		_planning_path.append(_ref_CreateObject.create_sprite(PlannedPath, _GroupName.PLANNED_PATH, x, y))

		_path.append([x, y])
		if [x, y] == [10, 4]:
			_ref_EnemyPath.try_create_path(_path)
			_stop_paiting_path()
		return
	
	if [x, y] != [2, 0] and [x, y] != [10, 4]:
		if _current_tile_type == _GroupName.TILE_GRASS:
			_ref_CreateObject.create_sprite(Grass, _GroupName.TILE, x, y, _GroupName.TILE_GRASS)
		if _current_tile_type == _GroupName.TILE_FIRE:
			var fire_tiles_count = _ref_PlayingBoard.get_number_of_tiles_of_type(_GroupName.TILE_FIRE)
			if fire_tiles_count < _max_fire_tiles:
				_ref_CreateObject.create_sprite(Fire, _GroupName.TILE, x, y, _GroupName.TILE_FIRE)
				emit_signal("update_fire_text", fire_tiles_count + 1, _max_fire_tiles)
	
	if _current_tile_type == _GroupName.PATH:
		if [x, y] == [2, 0]:
			_painting_path = true
			_planning_path.append(_ref_CreateObject.create_sprite(PlannedPath, _GroupName.PLANNED_PATH, x, y))
			_path = [[x, y]]
			_ref_PlayerControl.start_painting_path()


func _on_MouseControl_mouse_release():
	if _painting_path:
		_stop_paiting_path()


func _stop_paiting_path():
	for sprite in _planning_path:
		_ref_RemoveObject.remove(sprite)
	_planning_path = []
	_painting_path = false

	_ref_PlayerControl.end_painting_path()


func _on_PlayerControl_change_tile_type(type: String):
	_current_tile_type = type

