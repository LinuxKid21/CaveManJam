extends RigidBody2D

const CaveMan = preload("res://Characters/CaveMan.gd")
const Player = preload("res://Characters/Player.gd")

export var flipped = false

func _ready():
	if(flipped):
		pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	var overlapping = $death.get_overlapping_bodies()
	var hit_non_player = false
	for body in overlapping:
		if(body is CaveMan or body is Player):
			body.damage(1)
