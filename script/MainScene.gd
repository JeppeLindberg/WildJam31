extends Node2D

var __


func _ready():
	__ = get_node("PlayerControl").connect("change_state", get_node("EnemyAI"), "_on_PlayerControl_change_state")

	__ = get_node("PlayerControl").connect("change_tile_type", get_node("TilePainter"), "_on_PlayerControl_change_tile_type")
	
	__ = get_node("CreateObject").connect("sprite_created", get_node("PlayingBoard"), "_on_CreateObject_sprite_created")
	__ = get_node("CreateObject").connect("sprite_created", get_node("EnemyAI"), "_on_CreateObject_sprite_created")
	__ = get_node("CreateObject").connect("sprite_created", get_node("EnemyAI/EnemyPath"), "_on_CreateObject_sprite_created")

	__ = get_node("RemoveObject").connect("sprite_removed", get_node("EnemyAI"), "_on_RemoveObject_sprite_removed")
	__ = get_node("RemoveObject").connect("sprite_removed", get_node("EnemyAI/EnemyPath"), "_on_RemoveObject_sprite_removed")

	__ = get_node("EnemyAI").connect("update_remaining_life", get_node("MainGUI/RightPanel/RightPanelText"), "_on_EnemyAI_update_remaining_life")

	__ = get_node("TilePainter").connect("update_fire_text", get_node("MainGUI/RightPanel/RightPanelText"), "_on_TilePainter_update_fire_text")

	__ = get_node("MouseControl").connect("tile_click", get_node("TilePainter"), "_on_MouseControl_tile_click")

	__ = get_node("MouseControl").connect("mouse_release", get_node("TilePainter"), "_on_MouseControl_mouse_release")

	get_node("World")._ref_CreateObject = get_node("CreateObject")
	get_node("EnemyAI")._ref_CreateObject = get_node("CreateObject")
	get_node("EnemyAI/EnemyPath")._ref_CreateObject = get_node("CreateObject")
	get_node("TilePainter")._ref_CreateObject = get_node("CreateObject")
	
	get_node("EnemyAI/EnemyPath")._ref_RemoveObject = get_node("RemoveObject")
	get_node("PlayingBoard")._ref_RemoveObject = get_node("RemoveObject")
	get_node("TilePainter")._ref_RemoveObject = get_node("RemoveObject")
	
	get_node("World")._ref_EnemyPath = get_node("EnemyAI/EnemyPath")
	get_node("TilePainter")._ref_EnemyPath = get_node("EnemyAI/EnemyPath")
	
	get_node("MainGUI/TopBar/TileSelect")._ref_PlayerControl = get_node("PlayerControl")
	get_node("EnemyAI")._ref_PlayerControl = get_node("PlayerControl")
	get_node("TilePainter")._ref_PlayerControl = get_node("PlayerControl")

	get_node("TilePainter")._ref_PlayingBoard = get_node("PlayingBoard")
	
	get_node("World").ready_to_initialize = true
	get_node("PlayerControl").ready_to_initialize = true
