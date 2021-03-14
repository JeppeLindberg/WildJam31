extends Sprite

const EnemyPath := preload("res://script/EnemyPath.gd")
const PlayingBoard := preload("res://script/PlayingBoard.gd")
const RemoveObject := preload("res://script/RemoveObject.gd")

var _ref_EnemyPath: EnemyPath
var _ref_PlayingBoard: PlayingBoard
var _ref_RemoveObject: RemoveObject
var _ref_EnemyAI

var _health_bar: Sprite
var _health_bar_fill: Sprite

var _ConvertCoord := preload("res://script/library/ConvertCoord.gd").new()
var _GroupName := preload("res://script/library/GroupName.gd").new()

var _next_path_node: Array
var _speed: float = 50
var _health: float = 10
var _max_health: float = 0
var _damage_timer: float = 0
var _target_pos: Vector2
var paused: bool = false


func _ready():
	_ref_EnemyAI = get_node("../../EnemyAI")
	_ref_EnemyPath = get_node("../../EnemyAI/EnemyPath")
	_ref_PlayingBoard = get_node("../../PlayingBoard")
	_ref_RemoveObject = get_node("../../RemoveObject")

	_health_bar = get_node("HealthBar")
	_health_bar_fill = get_node("HealthBar/GreenPart")

	var path = _ref_EnemyPath.get_enemy_path()
	var start_x = path[0][0]
	var start_y = path[0][1]

	position = _ConvertCoord.index_to_vector(start_x, start_y)
	_target_pos = _ConvertCoord.index_to_vector(start_x, start_y)

	_next_path_node = path[1]


func _process(delta):
	if paused:
		return
	_move(delta * _speed)
	_process_damage(delta * 5)


func _move(delta):
	var _next_pos = _ConvertCoord.index_to_vector(_next_path_node[0], _next_path_node[1])
	var remaning_dist = _target_pos.distance_to(_next_pos)

	if delta < remaning_dist:
		_target_pos = _target_pos.move_toward(_next_pos, delta)
	else:
		_target_pos = _next_pos
		remaning_dist = remaning_dist - delta
		_next_path_node = _ref_EnemyPath.get_next_node(_next_path_node)

		if _next_path_node == []:
			_reached_end()
			return

		_move(remaning_dist)
	
	position = _target_pos.round()


func _process_damage(delta):
	_damage_timer += delta
	if _damage_timer > 1:
		_damage_timer -= 1

		var tile_type = _ref_PlayingBoard.get_tile_type_at_pos(_target_pos)

		if tile_type == _GroupName.TILE_FIRE:
			_take_damage(1)


func _take_damage(damage: float):
	if _max_health < _health:
		_max_health = _health
		
	_health -= damage
	if _health <= 0:
		_ref_RemoveObject.remove(self)
		
	_health_bar.visible = true
	_health_bar_fill.scale.x = (_health / _max_health)


func _reached_end():
	_ref_EnemyAI.enemy_reached_end()
	_ref_RemoveObject.remove(self)

