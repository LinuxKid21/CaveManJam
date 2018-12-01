extends Node

var unlocked = 1
var idols_found = []
var savegame = File.new()
var save_path = "user://savegame.bin"

func _ready():
	pass

func level_unlocked(i):
	unlocked = i if i > unlocked else unlocked

# currently unlocked level
func get_unlocked():
	return unlocked

func is_unlocked(i):
	return i > 0 and i <= get_unlocked()

func has_idol(i):
	return i in idols_found

func found_idol(i):
	if(not has_idol(i)):
		idols_found.append(i)
		save_game()
	print(idols_found)

func load_game():
	savegame.open(save_path, File.READ)
	if(not savegame.eof_reached()):
		var levels = savegame.get_line().strip_edges()
		var idols = savegame.get_line().strip_edges()
		
		if(levels != ""):
			unlocked = int(levels)
		if(idols != ""):
			var strings = idols.split(",")
			for string in strings:
				idols_found.append(int(string))
	get_tree().change_scene("res://Levels/Level_" + str(unlocked) + ".tscn")
	savegame.close()
	
func save_game():
	savegame.open(save_path, File.WRITE)
	savegame.store_line(str(unlocked))
	savegame.store_line(PoolStringArray(idols_found).join(","))
	savegame.close()
	