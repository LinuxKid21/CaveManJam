extends Area2D
const CaveMan = preload("res://Characters/CaveMan.gd")

export var speed = 500

var time = 0.0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position.x += delta * speed
	var overlapping = get_overlapping_bodies()
	for body in overlapping:
		if(body is CaveMan):
			body.damage(1)
			break
	
	time += delta
	
	if(overlapping.size() > 0 or time > 10):
		queue_free()
