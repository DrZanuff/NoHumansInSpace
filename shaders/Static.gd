extends AnimatedSprite



func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("Static")
	randomize()
	$Timer.start(rand_range(0.4,15))
