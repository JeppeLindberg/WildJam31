extends Node2D

var _World: Node2D

var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()

signal sprite_created(sprite)


func create_sprite(prefab: PackedScene, group:String, x: int, y: int, sub_group: String = "") -> Sprite:
	if _World == null:
		_World = get_node("../World")

	var new_sprite := prefab.instance() as Sprite
	new_sprite.position = _ConvertCoord.index_to_vector(x, y)
	new_sprite.add_to_group(group)
	if sub_group != "":
		new_sprite.add_to_group(sub_group)

	_World.add_child(new_sprite)

	emit_signal("sprite_created", new_sprite)

	return new_sprite

