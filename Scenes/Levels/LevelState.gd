extends Node2D
class_name LevelState

var time: float = 0
@export var target_time: float = 0

@export var coin: Coin
@export var flag: Flag

var coin_collected: bool = false
var flag_reached: bool = false

var time_running: bool = true

func _ready():
	coin.collected.connect(func(): coin_collected = true)
	flag.flag_reached.connect(func(): complete_level())

func _process(delta):
	time += delta

func complete_level():
	print("nivel completificado!!")
