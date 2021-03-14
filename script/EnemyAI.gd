extends Node2D

const Enemy := preload("res://sprite/Enemy.tscn")

var _GroupName := preload("res://script/library/GroupName.gd").new()
var _StateName := preload("res://script/library/StateName.gd").new()
var _EnemyWaves := preload("res://script/library/EnemyWaves.gd").new()

const CreateObject := preload("res://script/CreateObject.gd")
const PlayerControl := preload("res://script/PlayerControl.gd")
const TilePainter := preload("res://script/TilePainter.gd")

const ENEMY_PATH := "EnemyPath"

var _ref_CreateObject: CreateObject
var _ref_PlayerControl: PlayerControl
var _ref_TilePainter: TilePainter

var _enemies: Array
var _state: String
var _waves: Array
var _remaining_life: int = 10
var _enemy_spawn_timer: float = 0
var _wave_count: int = 0

var _enemies_to_spawn: int = 0
var _enemy_spawn_timer_speed: float = 1

signal update_remaining_life(new_value)
signal round_started()


func _ready():
	_waves = _EnemyWaves.get_all_waves()


func _process(delta):
	if _state == _StateName.ROUND_PLAY:
		_enemy_spawn_timer += delta * 0.75
		if _enemies_to_spawn > 0 and _enemy_spawn_timer > 1:
			var path = get_node(ENEMY_PATH).get_enemy_path()
			_ref_CreateObject.create_sprite(Enemy, _GroupName.ENEMY, path[0][0], path[0][1])
			_enemy_spawn_timer -= 1
			_enemies_to_spawn -= 1


func _start_round():
	_wave_count += 1

	var _current_wave = _waves[(_wave_count-1) % 5]
	_enemies_to_spawn = _current_wave.count + floor((_wave_count-1) / 5 as float)
	_enemy_spawn_timer_speed = _current_wave.frequency
	_enemy_spawn_timer = 0.9

	if _wave_count > 1 and (_wave_count-1) % 5 == 0:
		_ref_TilePainter.set_max_fire_tiles_plus_one()
	
	emit_signal("round_started")


func _on_PlayerControl_change_state(new_state: String) -> void:
	if new_state == _StateName.ROUND_PLAY:
		if _state == _StateName.BETWEEN_ROUNDS:
			_start_round()
		if _state == _StateName.ROUND_PAUSE:
			for enemy in _enemies:
				enemy.paused = false
	
	if new_state == _StateName.ROUND_PAUSE:
		for enemy in _enemies:
			enemy.paused = true
	
	_state = new_state


func enemy_reached_end() -> void:
	_remaining_life -= 1
	emit_signal("update_remaining_life", _remaining_life)

	
func _on_CreateObject_sprite_created(sprite: Sprite):
	if sprite.is_in_group(_GroupName.ENEMY):
		_enemies.append(sprite)
		var current_wave = _waves[(_wave_count-1) % 5]
		sprite._speed = current_wave.speed * (1 + (floor((_wave_count-1) / 5 as float) * 0.5))
		sprite._health = current_wave.health * (1 + (floor((_wave_count-1) / 5 as float) * 0.5))

		
func _on_RemoveObject_sprite_removed(sprite: Sprite):
	if sprite.is_in_group(_GroupName.ENEMY):
		_enemies.erase(sprite)
		if _enemies.size() == 0:
			_ref_PlayerControl.all_enemies_removed()
