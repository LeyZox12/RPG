class_name CommandRegistry

var commands = {}

func _init():
	registerCommand(SpecialGive)

func registerCommand(cmd):
	var instance = cmd.new()
	commands[instance.id] = instance
	print("Command " + instance.id + " registered")
	
