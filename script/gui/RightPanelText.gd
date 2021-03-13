extends VBoxContainer

var _life: Label
var _path_length: Label

const _life_text = "Life {0}"


func _ready():
	_life = get_node("Life")
	_path_length = get_node("PathLength")

	_life.text = _life_text.format([10]);


func _on_EnemyAI_update_remaining_life(new_value):
	_life.text = _life_text.format([new_value]);
