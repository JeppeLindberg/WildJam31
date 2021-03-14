extends Node2D

var _GroupName := preload("res://script/library/GroupName.gd").new()
var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()
var _WorldSize := preload("res://script/library/WorldSize.gd").new()

const RemoveObject := preload("res://script/RemoveObject.gd")

var _ref_RemoveObject: RemoveObject

var _tiles_dict: Dictionary
var _tile_types: Array = [_GroupName.TILE_GRASS, _GroupName.TILE_FIRE]


func _ready():
	_init_dict()


func _init_dict():
	_tiles_dict = {}
	for x in range(_WorldSize.MAX_X):
		_tiles_dict[x] = []
		_tiles_dict[x].resize(_WorldSize.MAX_Y)


func get_tile_type_at_pos(pos: Vector2) -> String:
	pos.x += _ConvertCoord.STEP_X/2 as float
	pos.y += _ConvertCoord.STEP_Y/2 as float
	if not _ConvertCoord.is_vector_in_coord(pos):
		return ""

	var array_pos = _ConvertCoord.vector_to_array(pos)
	var x = array_pos[0]
	var y = array_pos[1]
	
	for type in _tile_types:
		if _tiles_dict[x][y].is_in_group(type):
			return type
	return ""


func _on_CreateObject_sprite_created(sprite: Sprite):
	if not sprite.is_in_group(_GroupName.TILE):
		return
	
	var pos = _ConvertCoord.vector_to_array(sprite.position)
	var x = pos[0]
	var y = pos[1]

	if _tiles_dict[x][y] != null:
		_ref_RemoveObject.remove(_tiles_dict[x][y])

	_tiles_dict[x][y] = sprite


func get_number_of_tiles_of_type(type: String) -> int:
	var count: int = 0
	for x in range(_WorldSize.MAX_X):
		for y in range(_WorldSize.MAX_Y):
			if _tiles_dict[x][y].is_in_group(type):
				count += 1
	
	return count
