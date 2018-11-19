extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var speed = 80
export var gravitySpeed = 9.8*64
var velocity = Vector2(0,0)

var state = 'normal'
var last_floor = false
var last_velocity = Vector2(0,0)

func _ready():
	velocity.x = speed;
	_maybe_grunt()


func _normal(delta):
	
	var anim = "";
	
	# if in the air for .5 seconds then dead
	if(last_floor and last_velocity.y > gravitySpeed*1.25):
		velocity.x = 0
		state = 'dead'
	
	if(is_on_wall()):
		velocity.x *= -1
		_maybe_grunt()
		
	if(velocity.x > 0):
		velocity.x = speed
		$sprite.set_flip_h(true)
		anim = 'walk'
	elif(velocity.x < 0):
		velocity.x = -speed
		$sprite.set_flip_h(false)
		anim = 'walk'
	
	if(anim == ""):
		$sprite.stop()
	else:
		$sprite.play(anim)

func turn_around():
	velocity.x *= -1

func damage(amount):
	state = 'dead'
	velocity.x = 0

func _physics_process(delta):
	if(state == 'normal'):
		_normal(delta)
	if(state == 'dead'):
		$sprite.play('die')
		if($sprite.get_frame() >= 6):
			queue_free()
		return
		
	velocity.y += delta * gravitySpeed
		
	var new_velocity = move_and_slide(velocity, Vector2(0, -1), 5, 4, PI/4)
	last_floor = is_on_floor()
	last_velocity = velocity
	
	if(new_velocity.y < velocity.y):
		velocity.y = 0
	else:
		velocity.y = new_velocity.y

func _maybe_grunt():
	if(rand_range(0, 1) < .1):
		var choice = int(rand_range(0, 3))
		if(choice == 0):
			$grunt_1.play()
		if(choice == 1):
			$grunt_2.play()
		if(choice == 2):
			$grunt_3.play()
