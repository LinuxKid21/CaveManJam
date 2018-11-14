extends Area2D
const Crab = preload("res://Characters/Crab.gd")
const CaveMan = preload("res://Characters/CaveMan.gd")
const Player = preload("res://Characters/Player.gd")

export var speed = 500

var dead = false

var time = 0.0
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	time += delta
	if(time > 10):
		queue_free()
		
	if(dead):
		return
	
	position.x += delta * speed
	var overlapping = get_overlapping_bodies()
	var hit_non_player = false
	for body in overlapping:
		if(body is CaveMan or body is Crab):
			body.damage(1)
		if(not body is Player):
			hit_non_player = true
	
	if(hit_non_player):
		$particles.emitting = true
		$sprite.hide()
		dead = true
