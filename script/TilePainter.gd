extends Node2D

var _GroupName := preload("res://script/library/GroupName.gd").new()

const CreateObject := preload("res://script/CreateObject.gd")
const EnemyPath := preload("res://script/EnemyPath.gd")
const RemoveObject := preload("res://script/RemoveObject.gd")

var _ref_CreateObject: CreateObject
var _ref_EnemyPath: EnemyPath
var _ref_RemoveObject: RemoveObject

const Grass := preload("res://sprite/Grass.tscn")
const Fire := preload("res://sprite/Fire.tscn")
const PlannedPath := preload("res://sprite/PlannedPath.tscn")

var _current_tile_type: String

var _painting_path: bool = false
var _path: Array
var _planning_path: Array


func _on_MouseControl_tile_click(x: int, y: int):
	if _painting_path:
		_planning_path.append(_ref_CreateObject.create_sprite(PlannedPath, _GroupName.PLANNED_PATH, x, y))

		_path.append([x, y])
		if [x, y] == [10, 4]:
			_ref_EnemyPath.try_create_path(_path)
			_remove_planned_path()
			_painting_path = false
		return
	
	if [x, y] != [2, 0] and [x, y] != [10, 4]:
		if _current_tile_type == _GroupName.TILE_GRASS:
			_ref_CreateObject.create_sprite(Grass, _GroupName.TILE, x, y, _GroupName.TILE_GRASS)
		if _current_tile_type == _GroupName.TILE_FIRE:
			_ref_CreateObject.create_sprite(Fire, _GroupName.TILE, x, y, _GroupName.TILE_FIRE)
	
	if _current_tile_type == _GroupName.PATH:
		_planning_path.append(_ref_CreateObject.create_sprite(PlannedPath, _GroupName.PLANNED_PATH, x, y))

		if [x, y] == [2, 0]:
			_painting_path = true
			_path = [[x, y]]


func _on_MouseControl_mouse_release():
	if _painting_path:
		_painting_path = false
		_remove_planned_path()


func _remove_planned_path():
	for sprite in _planning_path:
		_ref_RemoveObject.remove(sprite)
	_planning_path = []


func _on_PlayerControl_change_tile_type(type: String):
	_current_tile_type = type

