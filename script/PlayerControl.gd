extends Node2D

var _InputName := preload("res://script/library/InputName.gd").new()
var _StateName := preload("res://script/library/StateName.gd").new()

signal change_state(new_state)
signal change_tile_type(type)

var _state: String
var ready_to_initialize: bool = false


func _process(_delta):
	if ready_to_initialize:
		_change_state(_StateName.BETWEEN_ROUNDS)
		set_process_unhandled_input(true)
		ready_to_initialize = false


func _unhandled_input(event):
	if _state == _StateName.BETWEEN_ROUNDS:
		if event.is_action_pressed(_InputName.START_ROUND):
			_change_state(_StateName.ROUND_PLAY)


func _change_state(new_state):
	print("New state <{0}>".format([new_state]))
	_state = new_state
	emit_signal("change_state", _state)


func tile_type_selected(type: String):
	emit_signal("change_tile_type", type)


func all_enemies_removed():
	if _state == _StateName.ROUND_PLAY or _state == _StateName.ROUND_PAUSE:
		_change_state(_StateName.BETWEEN_ROUNDS)


func start_painting_path():
	if _state == _StateName.ROUND_PLAY:
		_change_state(_StateName.ROUND_PAUSE)


func end_painting_path():
	if _state == _StateName.ROUND_PAUSE:
		_change_state(_StateName.ROUND_PLAY)