extends Area2D

# basic signal example
func _on_body_entered(body):
	
	# can print body name to tell what is happening
	if body.name == "Player":
		get_tree().reload_current_scene()
