extends KinematicBody2D

const CaveMan = preload("res://Characters/CaveMan.gd")
const Player = preload("res://Characters/Player.gd")

export var speed = 80
export var gravitySpeed = 9.8*64
var velocity = Vector2(0,0)

var dead = false
var fading = 1

func _ready():
	velocity.x = speed;
	if(speed < 0):
		speed *= -1

func _normal(delta):
	if(velocity.x > 0):
		velocity.x = speed
		$sprite.set_flip_h(true)
	elif(velocity.x < 0):
		velocity.x = -speed
		$sprite.set_flip_h(false)
		
	velocity.y += delta * gravitySpeed
		
	var new_velocity = move_and_slide(velocity, Vector2(0, -1), 5, 4, PI/4)
	
	if(new_velocity.y < velocity.y):
		velocity.y = 0
	else:
		velocity.y = new_velocity.y
	
	
	
	if(is_on_wall()):
		var turn_around = true
		var count = get_slide_count()
		for i in range(count):
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if(collider and collider is CaveMan or collider is Player):
				turn_around = false
				collider.damage(1)
		if(turn_around):
			velocity.x *= -1

func turn_around():
	velocity.x *= -1

func damage(amount):
	dead = true
	$sprite.play("die")

var has_collision = true
func _physics_process(delta):
	if(not dead):
		_normal(delta)
	elif($sprite.get_frame() >= 5 and has_collision):
		$collision.queue_free()
		has_collision = false
		fading = .9999
	elif(fading < 1):
		fading -= delta * 3
		$sprite.set("modulate", Color(1,1,1,fading))
		if(fading <= 0):
			queue_free()
