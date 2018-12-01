extends Area2D
const Player = preload("res://Characters/Player.gd")

var called = false

func _on_Idol_body_entered(body):
	if(body is Player and not called):
		$Tween.interpolate_property($idol, "scale", Vector2(1,1), Vector2(2,2), .5, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.interpolate_property($idol, "modulate", Color(1,1,1,1), Color(1, 1, 1, 0), .5, Tween.TRANS_EXPO, Tween.EASE_IN)
		$Tween.start()
		called = true
		$Particles2D.set_emitting(true)
		body.on_found_idle()
		$audio.play()
		
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "queue_free")
		timer.set_wait_time(2.5)
		timer.start()

