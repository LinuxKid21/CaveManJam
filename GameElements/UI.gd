extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var saved = 0
export var need_to_save = 5

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Portal_cave_man_saved():
	saved += 1
	var saved_ui = $MarginContainer/VBoxContainer/HBoxContainer/Saved
	saved_ui.set_text(str(saved))
	
	if(saved == need_to_save):
		saved_ui.set("custom_colors/font_color", Color(1,1,1))
