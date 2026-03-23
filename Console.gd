extends Control

@onready var input = $Input

var commandRegistry = CommandRegistry.new()
var previews

func getPossible(str):
	var out = []
	if str.length() == 0:
		return []
	for v in commandRegistry.commands.keys():
		if str in v:
			out.push_back(v)
	return out


func runCommand(str):
	var cmd = str.split(" ")
	if cmd.size() != 0:
		var args = []
		for i in range(cmd.size()):
			if i != 0:
				args.push_back(cmd[i])
		commandRegistry.commands[cmd[0]].task(args, $"../../..")

func _input(event):
	if not visible or not $Input.has_focus():
		return
	if event.is_action_pressed("confirm"):
		runCommand($Input.text)
		call_deferred("empty")

func empty():
	$Input.text = ""

func _onInputUpdate():
	var str = $Input.text
	for i in range(8):
		$VBoxContainer.get_node("Preview" + str(i+1)).get_node("Label").text = ""
	var possibles = getPossible(str)
	for i in range(len(possibles)):
		var p = $VBoxContainer.get_node("Preview" + str(i+1))
		p.get_node("Label").text = possibles[i]
		
	pass
