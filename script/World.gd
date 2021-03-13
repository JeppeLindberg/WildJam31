extends Node2D

const Grass := preload("res://sprite/Grass.tscn")
const Plate := preload("res://sprite/Plate.tscn")

const EnemyPath := preload("res://script/EnemyPath.gd")
const CreateObject := preload("res://script/CreateObject.gd")

var _WorldSize := preload("res://script/library/WorldSize.gd").new()
var _GroupName := preload("res://script/library/GroupName.gd").new()

var _ref_EnemyPath: EnemyPath
var _ref_CreateObject: CreateObject

var ready_to_initialize: bool = false


func _process(_delta):
	if ready_to_initialize:
		_init_world()
		ready_to_initialize = false


func _init_world():
	#Create tiles
	for x in range(0, _WorldSize.MAX_X):
		for y in range(0, _WorldSize.MAX_Y):
			if ([x, y] == [2,0]) or ([x, y] == [10, 4]):
				_ref_CreateObject.create_sprite(Plate, _GroupName.TILE, x, y, _GroupName.TILE_PLATE)
			else:
				_ref_CreateObject.create_sprite(Grass, _GroupName.TILE, x, y, _GroupName.TILE_GRASS)

	#Create path
	_ref_EnemyPath.try_create_path(_get_initial_path())


func _get_initial_path() -> Array:
	return [[2, 0], \
			[2, 1], \
			[2, 2], \
			[2, 3], \
			[2, 4], \
			[3, 4], \
			[4, 4], \
			[5, 4], \
			[6, 4], \
			[7, 4], \
			[8, 4], \
			[9, 4], \
			[10, 4]]
