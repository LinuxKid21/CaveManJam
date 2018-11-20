extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var saved = 0
var need_to_save = 5
export var next_level = -1

var tutorial_lines = Array()
var line_idx = 0
var can_unpause = false
onready var disp_ui = $MarginContainer/VBoxContainer/Tutorial

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var next_level_ui = $MarginContainer/VBoxContainer/NextLevelRow/NextLevel
	var tween = $MarginContainer/VBoxContainer/NextLevelRow/tween
	tween.interpolate_property(next_level_ui, "modulate", Color(1,1,1), Color(1,.25,0), 1, Tween.TRANS_SINE, Tween.EASE_OUT_IN)
	tween.interpolate_property(next_level_ui, "modulate", Color(1,.25,0), Color(1,1,1), 1, Tween.TRANS_SINE, Tween.EASE_OUT_IN, 1)
	tween.start()

var time = 0
func _process(delta):
	if(line_idx >= len(tutorial_lines)):
		can_unpause = true
		disp_ui.set_text("")
	else:
		var line = tutorial_lines[line_idx]
		var letter_count = int(time * 50)
		
		var excess = 0
		if(letter_count >= len(line)):
			excess = letter_count - len(line)
			letter_count = len(line)
		var display = line.substr(0,letter_count)
		disp_ui.set_text(display)
		
		if(excess >= 100 or Input.is_action_just_pressed("escape")):
			line_idx += 1
			time = 0
	time += delta


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
