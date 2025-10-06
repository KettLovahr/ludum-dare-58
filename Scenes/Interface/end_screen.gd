extends Control

func _on_main_menu_pressed() -> void:
	Transition.change_scene_to_file("res://Scenes/Interface/main_menu.tscn")

func _ready() -> void:
	if GameState.got_all_tombstones():
		$Label3.text = "Congrats on 100% and thank you for playing :D"
