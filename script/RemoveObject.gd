extends Node2D

var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()

signal sprite_removed(remove_sprite)


func remove(sprite) -> void:
	emit_signal("sprite_removed", sprite)
	sprite.queue_free()