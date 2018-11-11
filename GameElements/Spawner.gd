extends Node2D

export var interval = 1.0

func _ready():
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.set_wait_time(interval)
	timer.start()

func _on_timer_timeout():
	var cave_man = preload( "res://Characters/CaveMan.tscn" ).instance()
	get_node(".").add_child(cave_man)
	

func _process(delta):
	pass
