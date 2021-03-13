extends Node2D

var _GroupName := preload("res://script/library/GroupName.gd").new()
var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()
var _WorldSize := preload("res://script/library/WorldSize.gd").new()
var _InputName := preload("res://script/library/InputName.gd").new()

var _process_input: bool = false
var _mouse_down: bool = false
var _prev_x: int
var _prev_y: int

const MOUSE_LEFT := 1

signal tile_click(x, y)
signal mouse_release()


func _input(event):
	if not ((event is InputEventMouseButton) or (event is InputEventMouseMotion)):
		return

	if event is InputEventMouseButton:
		var event_mouse: InputEventMouseButton = event as InputEventMouseButton

		if (event_mouse.button_index == MOUSE_LEFT) and (event_mouse.pressed):
			_mouse_down = true
		if (event_mouse.button_index == MOUSE_LEFT) and (not event_mouse.pressed):
			_prev_x = -999
			_prev_y = -999
			if _mouse_down:
				emit_signal("mouse_release")
			_mouse_down = false

	if not _mouse_down:
		return

	var eventpos = event.position
	eventpos.x += _ConvertCoord.STEP_X/2 as float
	eventpos.y += _ConvertCoord.STEP_Y/2 as float
	if (eventpos.x < _ConvertCoord.START_X) or \
		(eventpos.y < _ConvertCoord.START_Y):
		return
	
	var pos = _ConvertCoord.vector_to_array(eventpos)
	var x = pos[0]
	var y = pos[1]

	if not ((0 <= x) and (x < _WorldSize.MAX_X) and \
		(0 <= y) and (y < _WorldSize.MAX_Y)):
		return

	if x == _prev_x and y == _prev_y:
		return

	print("Mouse click {0}, {1}".format([x, y]))
	emit_signal("tile_click", x, y)

	_prev_x = x
	_prev_y = y