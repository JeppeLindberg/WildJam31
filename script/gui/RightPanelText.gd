extends VBoxContainer

var _life: Label
var _fire_count: Label

const _life_text = "Life {0}"
const _fire_text = "Fire {0}/{1}"


func _ready():
	_life = get_node("Life")
	_fire_count = get_node("FireCount")

	_life.text = _life_text.format([10]);
	_fire_count.text = _fire_text.format([0, 2]);


func _on_EnemyAI_update_remaining_life(new_value):
	_life.text = _life_text.format([new_value]);


func _on_TilePainter_update_fire_text(current:int, max_count:int):
	_fire_count.text = _fire_text.format([current, max_count]);
