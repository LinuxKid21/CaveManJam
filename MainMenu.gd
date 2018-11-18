extends CenterContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_on_MasterVolume_value_changed(250)
	_on_MusicVolume_value_changed(100)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Level1_pressed():
	get_tree().change_scene("res://Levels/Level_1.tscn")


func _on_Level2_pressed():
	get_tree().change_scene("res://Levels/Level_2.tscn")

func _log_2(amount):
	return log(amount) / log(2)

func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 6*(_log_2(value)-_log_2(100)))


func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 6*(_log_2(value)-_log_2(100)))
	print(6*(_log_2(value)-_log_2(100)))
