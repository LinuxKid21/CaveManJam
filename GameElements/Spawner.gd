extends Node2D

export var interval = 1.0
export var flipped = false
export var count = -1

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.set_wait_time(interval)
	timer.start()

func _on_timer_timeout():
	if(count == 0):
		return
	count -= 1
	
	var cave_man = preload( "res://Characters/CaveMan.tscn" ).instance()
	cave_man.position = position
	get_parent().add_child(cave_man)
	if(flipped):
		cave_man.turn_around()
	

func _process(delta):
	pass
