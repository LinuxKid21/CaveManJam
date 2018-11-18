extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var speed = 300
export var gravitySpeed = 9.8*64

export var required_cave_men = 5
export var next_level = -1

var velocity = Vector2(0,0)
var facing_right = false

var time_idle = 0.0
var time_in_state = 0.0

var last_floor_height = get_position().y

var anim = 'idle'
var last_anim = anim

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#Input.set_custom_mouse_cursor(crosshair_img)
	last_floor_height = get_position().y
	$UI.set_required(required_cave_men)
	$UI.next_level = next_level

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
#	if(Input.is_action_pressed("player_fire")):
	pass

func _physics_process(delta):
	last_anim = anim
	velocity.y += delta * gravitySpeed
	
	if(abs(velocity.x) < 1*delta):
		velocity.x = 0;
	elif(velocity.x > 0):
		velocity.x -= 1500 * delta
	elif(velocity.x < 0):
		velocity.x += 1500 * delta

	if(anim != 'shoot' and anim != 'jump'):
		anim = 'idle'

	if(anim == 'shoot' and $sprite.get_frame() >= 11):
		anim = 'idle'
		$sprite.set_frame(0)
		
	if(anim != 'shoot'):
		if(Input.is_action_pressed("player_move_right") and not Input.is_action_pressed("player_fire")):
			velocity.x = speed
			$sprite.set_flip_h(true)
			if(is_on_floor()):
				anim = 'walk'
			facing_right = true
		if(Input.is_action_pressed("player_move_left") and not Input.is_action_pressed("player_fire")):
			velocity.x = -speed
			$sprite.set_flip_h(false)
			if(is_on_floor()):
				anim = 'walk'
			facing_right = false
		if(Input.is_action_pressed("player_jump")):
			if(is_on_floor()):
				velocity.y = -500
		if(Input.is_action_pressed("player_fire")):
			anim = 'shoot'
			var bullet = preload( "res://Characters/PlayerBullet.tscn" ).instance()
			bullet.position = position + Vector2(10 * (1 if facing_right else -1),-20)
			if(not facing_right):
				bullet.speed *= -1
				velocity.x += 750
			else:
				velocity.x -= 750
			get_parent().add_child(bullet)
		
		if(not is_on_floor() and anim != 'shoot'):
			anim = 'jump'
		elif(is_on_floor() and anim == 'jump'):
			anim = 'idle'
		
		if(is_on_floor() and anim == 'walk'):
			if(last_anim != 'walk'):
				$run_sound.play()
		else:
			$run_sound.stop()
		
		if(anim == 'idle'):
			time_idle += delta
		else:
			time_idle = 0
		
		if(time_idle > 3):
			time_idle = -4
		
		if(time_idle < 0 and anim == 'idle'):
			anim = 'bored'
	if(anim == ""):
		$sprite.stop()
	else:
		$sprite.play(anim)
		
	var new_velocity = move_and_slide(velocity, Vector2(0, -1), 5, 4, PI/4)
	if(new_velocity.y < velocity.y):
		velocity.y = 0
	else:
		velocity.y = new_velocity.y
		
	
	if(is_on_floor()):
		last_floor_height = get_position().y
	else:
		if(position.y - last_floor_height > 4000): # dead
			get_tree().reload_current_scene()
#	for i in range(get_slide_count()):
#		collision = get_slide_collision(i)
#		collision.collider.
	