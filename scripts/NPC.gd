class_name NPC extends Node

var dialogFile:JSON
var msgIndex = 0
var lineIndex = -1#start at -1 because +1 in getMessage function

func _loadDialog(path):
	dialogFile = load(path)

func getDialog():
	return dialogFile
	
func _onCollision(obj):
	if obj.name == "Player":
		obj.initDialog(self)
func getMessage():
	lineIndex+=1
	return dialogFile.data["EN_US"]["messages"][msgIndex][lineIndex]
