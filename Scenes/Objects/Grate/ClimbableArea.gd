extends Area2D
class_name ClimbableArea


func _on_body_entered(body: Node2D) -> void:
	if body is Ribcage:
		if self not in body.climbable_areas:
			body.climbable_areas.append(self)
			print(body.climbable_areas)


func _on_body_exited(body: Node2D) -> void:
	if body is Ribcage:
		for i in range(len(body.climbable_areas)):
			if body.climbable_areas[i] == self:
				body.climbable_areas.remove_at(i)
				body.handle_can_still_climb()
				break
		print(body.climbable_areas)
