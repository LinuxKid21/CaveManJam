extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func damage(amount):
	$SpikeStand.play("explode")
	$collision.queue_free()
	#queue_free()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if($SpikeStand.get_frame() >= 5):
		queue_free()
