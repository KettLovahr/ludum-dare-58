extends Node2D
class_name LevelState

var time: float = 0
@export var target_time: float = 0

@export var coin: Coin
@export var flag: Flag

var coin_collected: bool = false
var time_running: bool = true

const LEVEL_COMPLETED = preload("res://Scenes/Interface/level_finished.tscn")

func _ready():
	coin.collected.connect(func(): coin_collected = true)
	flag.flag_reached.connect(func(): complete_level())
	time_running = true

func _process(delta):
	if not time_running:
		return
	time += delta

func complete_level():
	time_running = false
	await get_tree().create_timer(0.5).timeout
	$PlayerRoot.disabled = true
	var completed = LEVEL_COMPLETED.instantiate()
	add_child(completed)
	completed.complete([true, coin_collected, time <= target_time], target_time)
