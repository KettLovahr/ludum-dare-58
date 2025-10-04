extends Node2D
class_name LevelState

var time: float = 0
@export var target_time: float = 0

var coin_collected: bool = false
var flag_reached: bool = false

func _process(delta):
	time += delta
