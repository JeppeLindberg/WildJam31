const START_X: int = 130
const START_Y: int = 170
const STEP_X: int = 64
const STEP_Y: int = 64

var _WorldSize := preload("res://script/library/WorldSize.gd").new()


func vector_to_array(vector_coord: Vector2) -> Array:
    var x: int = ((vector_coord.x - START_X) / STEP_X) as int
    var y: int = ((vector_coord.y - START_Y) / STEP_Y) as int

    return [x, y]


func index_to_vector(x: int, y: int, x_offset: int = 0, y_offset: int = 0) -> Vector2:
    var x_vector: int = START_X + STEP_X * x + x_offset
    var y_vector: int = START_Y + STEP_Y * y + y_offset

    return Vector2(x_vector, y_vector)


func is_vector_in_coord(vector_coord: Vector2) -> bool:
    if (vector_coord.x < START_X) or \
        (vector_coord.y < START_Y):
        return false

    if (vector_coord.x > START_X + STEP_X * _WorldSize.MAX_X) or \
        (vector_coord.y > START_Y + STEP_Y * _WorldSize.MAX_Y):
        return false
    
    return true

func index_distance(from_x: int, from_y:int, to_x: int, to_y) -> int:
    return (abs(from_x - to_x) + abs(from_y - to_y)) as int