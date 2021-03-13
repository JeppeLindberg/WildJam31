extends Node2D

const Enemy := preload("res://sprite/Enemy.tscn")

var _GroupName := preload("res://script/library/GroupName.gd").new()

const CreateObject := preload("res://script/CreateObject.gd")

const ENEMY_PATH := "EnemyPath"

var _ref_CreateObject: CreateObject

var _remaining_life: int = 10

signal update_remaining_life(new_value)


func _start_round():
    var path = get_node(ENEMY_PATH).get_enemy_path()
    _ref_CreateObject.create_sprite(Enemy, _GroupName.ENEMY, path[0][0], path[0][1])


func _on_PlayerControl_start_round() -> void:
    _start_round()


func enemy_reached_end() -> void:
    _remaining_life -= 1
    emit_signal("update_remaining_life", _remaining_life)

    