extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dead = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(Input.is_action_pressed("player_trigger") and not dead):
		var expl = preload("res://assets/ExplosionEffect.tscn").instance()
		expl.position = get_parent().position
		get_parent().get_parent().add_child(expl)
		
		get_parent().damage(1)
		$particles.set_emitting(false)
		dead = true
