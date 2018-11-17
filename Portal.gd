extends Area2D
const CaveMan = preload("res://Characters/CaveMan.gd")

signal cave_man_saved

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var overlapping = get_overlapping_bodies()
	for body in overlapping:
		if(body is CaveMan):
			body.queue_free()
			emit_signal("cave_man_saved")
