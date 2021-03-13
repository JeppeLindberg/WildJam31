extends Node2D

var _InputName := preload("res://script/library/InputName.gd").new()

signal start_round()
signal change_tile_type(type)


func _ready():
	set_process_unhandled_input(true)


func _unhandled_input(event):
	if event.is_action_pressed(_InputName.START_ROUND):
		emit_signal("start_round")


func tile_type_selected(type: String):
	emit_signal("change_tile_type", type)