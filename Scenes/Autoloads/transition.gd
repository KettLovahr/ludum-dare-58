extends CanvasLayer

func change_scene_to_file(path: String):
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(path)
	$AnimationPlayer.play("in")

func reload_current_scene():
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play("in")
