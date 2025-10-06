extends Trigger
class_name ButtonSwitch

var activated: bool = false

var bodies: Array[PlayerPart]

const PRESSED_HEIGHT = 16
const RELEASE_HEIGHT = 36

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerPart:
		if len(bodies) == 0:
			press()
		bodies.append(body)

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerPart:
		for i in len(bodies):
			if bodies[i] == body:
				bodies.remove_at(i)
				break
		if len(bodies) == 0:
			release()

func button_state_change(on: bool):
	if activated == on:
		return
	activated = on
	create_tween()\
		.tween_property(
			$Button,
			"region_rect",
			Rect2(0, 0, 92, PRESSED_HEIGHT if on else RELEASE_HEIGHT),
			TRIGGER_TIME
		)
	await get_tree().create_timer(TRIGGER_TIME).timeout
	state_changed.emit(on)
	print("button pressed!" if on else "button released!")

@onready var pressed_sfx: AudioStreamPlayer = $PressedSFX

func release():
	button_state_change(false)
	pressed_sfx.play()
	pressed_sfx.pitch_scale = 0.8

func press():
	button_state_change(true)
	pressed_sfx.play()
	pressed_sfx.pitch_scale = 1.0
