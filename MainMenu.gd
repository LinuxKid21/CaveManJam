extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	#_on_MasterVolume_value_changed(250)
	#_on_MusicVolume_value_changed(100)
	var play_menu = $"Control/CenterContainer/Tabs/Play Game!"
	for i in range(len(play_menu.get_children())):
		if(i == 0):
			continue
		play_menu.get_child(i).get_child(1).set_disabled(not GameLoad.is_unlocked(i))
		play_menu.get_child(i).get_child(2).get_child(0).set_visible(GameLoad.has_idol(i))
		play_menu.get_child(i).get_child(1).connect("pressed", self, "_on_level_pressed", [i])

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _log_2(amount):
	return log(amount) / log(2)

func _on_MasterVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 6*(_log_2(value)-_log_2(100)))


func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), 6*(_log_2(value)-_log_2(100)))
	print(6*(_log_2(value)-_log_2(100)))


func _on_level_pressed(idx):
	get_tree().change_scene("res://Levels/Level_" + str(idx) + ".tscn")
	

func _on_Level1_pressed():
	get_tree().change_scene("res://Levels/Level_1.tscn")


func _on_Level2_pressed():
	get_tree().change_scene("res://Levels/Level_2.tscn")
	
	

func _on_Level3_pressed():
	get_tree().change_scene("res://Levels/Level_3.tscn")


func _on_Level4_pressed():
	get_tree().change_scene("res://Levels/Level_4.tscn")


func _on_Level5_pressed():
	get_tree().change_scene("res://Levels/Level_5.tscn")


func _on_Level6_pressed():
	get_tree().change_scene("res://Levels/Level_6.tscn")


func _on_Level7_pressed():
	get_tree().change_scene("res://Levels/Level_7.tscn")



func set_tab(idx):
	$Control/CenterContainer/Tabs.set_current_tab(idx)

func _on_Play_pressed():
	set_tab(1)


func _on_Settings_pressed():
	set_tab(2)


func _on_Keyboard_pressed():
	set_tab(3)
	
func _on_ArrowControls_pressed():
	set_tab(4)
	
func _on_XBox_pressed():
	set_tab(5)

func _on_Credits_pressed():
	set_tab(6)

func _on_Quit_pressed():
	set_tab(7)

func _on_Back_pressed():
	set_tab(0)






func _on_RealQuit_pressed():
	get_tree().quit()
