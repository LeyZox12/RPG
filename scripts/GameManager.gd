extends Node

var lang = "EN_US"
var playerName = "Tom"

var itemRegistry = ItemRegistry.new()

func loadRoom(path):
	var map = load(path)
	var instance = map.instantiate()
	add_child(instance)
func _ready():
	#loadRoom("res://0_0.tscn")
	loadSettings()


func loadSettings():
	if not FileAccess.file_exists("user://save.dat"):
		var f = FileAccess.open("user://save.dat", FileAccess.WRITE)
		f.store_line("EN_US")
		f.store_line("Tom")
	else:
		var f = FileAccess.open("user://save.dat", FileAccess.READ)
		lang = f.get_line()
		playerName = f.get_line()
