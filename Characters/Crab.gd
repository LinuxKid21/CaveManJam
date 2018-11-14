extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var speed = 80
export var gravitySpeed = 9.8*64
var velocity = Vector2(0,0)

var max_health = 3.0
var health = max_health

func _ready():
	velocity.x = speed;

func _normal(delta):
	
	if(is_on_wall()):
		velocity.x *= -1
		
	if(velocity.x > 0):
		velocity.x = speed
		$sprite.set_flip_h(true)
	elif(velocity.x < 0):
		velocity.x = -speed
		$sprite.set_flip_h(false)

func turn_around():
	velocity.x *= -1

func damage(amount):
	health -= amount
	if(health <= 0):
		health = 0
		queue_free()
	$healthbar.set_percent(health/max_health)
	
func _physics_process(delta):
	_normal(delta)
		
	velocity.y += delta * gravitySpeed
		
	var new_velocity = move_and_slide(velocity, Vector2(0, -1), 5, 4, PI/4)
	
	if(new_velocity.y < velocity.y):
		velocity.y = 0
	else:
		velocity.y = new_velocity.y
