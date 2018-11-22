extends Node

const Ant = preload("res://Characters/Ant.gd")
const CaveMan = preload("res://Characters/CaveMan.gd")

onready var tile_set = get_node("/root/Node/TileMap")
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var dead = false
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _explode_anim(pos):
		var expl = preload("res://assets/ExplosionEffect.tscn").instance()
		expl.position = pos
		get_parent().get_parent().add_child(expl)

func _explode_cell(vec):
	var cell = tile_set.get_cellv(vec)
	if(cell != -1 and cell != 0): # 0 is rock
		tile_set.set_cellv(vec, -1)
		_explode_anim(tile_set.map_to_world(vec) + Vector2(32,32))

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(Input.is_action_pressed("player_trigger") and not dead):
		_explode_anim(get_global_position())
		
		var overlapping = $area.get_overlapping_bodies()
		for body in overlapping:
			if(body is CaveMan or body is Ant and body != get_parent()):
				body.damage(1)
		
		var tile_pos = tile_set.world_to_map(get_parent().global_position)
		
		_explode_cell(tile_pos + Vector2( 0,  1))
		_explode_cell(tile_pos + Vector2( 0, -1))
		_explode_cell(tile_pos + Vector2( 1,  0))
		_explode_cell(tile_pos + Vector2(-1,  0))
			

		get_parent().damage(1)
		$particles.set_emitting(false)
		dead = true
