class_name NPC extends Area2D

var dialogFile:JSON
var msgIndex = 0
var lineIndex = 0

func _init():
	body_entered.connect(_onCollision)

func _loadDialog(path):
	dialogFile = load(path)

func getDialog():
	return dialogFile
	
func _onCollision(obj):
	print("gehllo")
	if obj.name == "Player":
		obj.initDialog(self)
func getMessage():
	var msg = dialogFile.data["EN_US"]["messages"][msgIndex][lineIndex]
	lineIndex+=1
	return msg
