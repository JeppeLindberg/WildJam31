extends Node2D

const Path := preload("res://sprite/Path.tscn")

const CreateObject := preload("res://script/CreateObject.gd")
const RemoveObject := preload("res://script/RemoveObject.gd")

var _GroupName := preload("res://script/library/GroupName.gd").new()
var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()

var _ref_CreateObject: CreateObject
var _ref_RemoveObject: RemoveObject

var _path: Array
var _path_objects: Array
var _enemies: Array


func try_create_path(new_path: Array) -> bool:
	if new_path[0] != [2, 0]:
		print("ERROR: Path starts at wrong node")
		return false
		
	if new_path[new_path.size()-1] != [10, 4]:
		print("ERROR: Path ends at wrong node")
		return false

	new_path.insert(0, [2, -1])
	new_path.append([11, 4])

	var prev_node
	for node in new_path:
		if prev_node != null:
			if _ConvertCoord.index_distance(prev_node[0], prev_node[1], node[0], node[1]) != 1:
				print("ERROR: Path has diagonal nodes")
				return false
		prev_node = node

	for node in new_path:
		if new_path.find(node, new_path.find(node)+1) != -1:
			print("ERROR: Path has dublicate nodes")
			return false

	for enemy in _enemies:
		if new_path.find(enemy._next_path_node) == -1:
			print("ERROR: Enemies will get lost on that path")
			return false
		
	for object in _path_objects:
		_ref_RemoveObject.remove(object)
	_path_objects = []

	for node in new_path:
		_path_objects.append(_ref_CreateObject.create_sprite(Path, _GroupName.PATH, node[0], node[1]))
	
	_path = new_path
	return true


func get_enemy_path() -> Array:
	return _path


func get_next_node(from_node: Array) -> Array:
	var index = _path.find(from_node)
	if index == _path.size()-1:
		return[]
	return _path[index+1]

	
func _on_CreateObject_sprite_created(sprite: Sprite):
	if sprite.is_in_group(_GroupName.ENEMY):
		_enemies.append(sprite)

		
func _on_RemoveObject_sprite_removed(sprite: Sprite):
	if sprite.is_in_group(_GroupName.ENEMY):
		_enemies.erase(sprite)
