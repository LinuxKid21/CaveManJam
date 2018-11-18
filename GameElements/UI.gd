extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var saved = 0
var need_to_save = 5
export var next_level = -1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_required(amount):
	need_to_save = amount
	var must_save_ui = $MarginContainer/VBoxContainer/HBoxContainer/Total
	must_save_ui.set_text(str(amount))

func _on_Portal_cave_man_saved():
	saved += 1
	var saved_ui = $MarginContainer/VBoxContainer/HBoxContainer/Saved
	saved_ui.set_text(str(saved))
	
	if(saved == need_to_save):
		saved_ui.set("custom_colors/font_color", Color(1,1,1))
		var next_level_ui = $MarginContainer/VBoxContainer/NextLevelRow/NextLevel
		var restart_level_ui = $MarginContainer/VBoxContainer/NextLevelRow/Restart
		next_level_ui.set_visible(true)
		restart_level_ui.set_visible(false)


func _on_NextLevel_pressed():
	if(next_level == -1):
		pass # TODO end of game congrats
	else:
		get_tree().change_scene("res://Levels/Level_" + str(next_level) + ".tscn")
	


func _on_Restart_pressed():
	get_tree().reload_current_scene()
