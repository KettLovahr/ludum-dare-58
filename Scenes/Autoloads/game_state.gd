extends Node

@export_file_path("*.tscn") var level_scene_paths: Array[String]
var unlocked := 0
var current_level := 0
var tombstones_state := []

func _ready() -> void:
	for level in level_scene_paths:
		tombstones_state.append([false, false, false])

func update_tombstones(level_id: int, tombstones: Array):
	var i := 0
	for value in tombstones_state[level_id]:
		tombstones_state[level_id][i] = tombstones_state[level_id][i] or tombstones[i]
		i += 1

func got_all_tombstones() -> bool:
	for state in tombstones_state:
		for value in state:
			if not value:
				return false
	return true
