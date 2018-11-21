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

var time = 0

export var tutorial_file = ""

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#Input.set_custom_mouse_cursor(crosshair_img)
	last_floor_height = get_position().y
	$UI.set_required(required_cave_men)
	$UI.next_level = next_level
	
	if(tutorial_file != ""):
		var file = File.new()
		file.open(tutorial_file, file.READ)
		$UI.tutorial_lines = file.get_as_text().split("\n")


var interpolate_time = 0
func _process(delta):
	time += delta
	
	if(time < 3 and not Input.is_action_pressed("escape")):
		get_tree().paused = true
		$camera.set_zoom(Vector2(3,3))
	elif($UI.can_unpause):
		time = 999 # some large number
		get_tree().paused = false
		$camera.set_zoom(Vector2(1,1))
		
	if(get_tree().paused):
		return
		
	
	last_anim = anim
	
	
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
		
	
	if(is_on_floor()):
		last_floor_height = get_position().y
	else:
		if(position.y - last_floor_height > 4000): # dead
			damage(1)
			
	
	# Interpolate	
	var alpha = interpolate_time / (1.0/60.0)
	var inverse_alpha = 1 - alpha
	var to_last_pos = prev_position - get_position()
	var desired_draw_offset = to_last_pos * inverse_alpha
	$sprite.set_position(desired_draw_offset)
	interpolate_time += delta

func damage(amount):
	get_tree().reload_current_scene()

var prev_position = get_position()
func _physics_process(delta):
	if(get_tree().paused):
		return
	
	prev_position = get_position()
	interpolate_time = 0
	
	velocity.y += delta * gravitySpeed
	
	
	if(abs(velocity.x) < 1*delta):
		velocity.x = 0;
	elif(velocity.x > 0):
		velocity.x -= 1500 * delta
	elif(velocity.x < 0):
		velocity.x += 1500 * delta

		
	var new_velocity = move_and_slide(velocity, Vector2(0, -1), 1)
	velocity.y = new_velocity.y
		
	