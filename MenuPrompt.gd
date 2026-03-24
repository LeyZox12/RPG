extends Control

@onready var player = $"../../../../Player"
@onready var root = $"../../../.."

@onready var btns = [$VBoxContainer/B1, $VBoxContainer/B2, $VBoxContainer/B3]
var currIndex = 0

func equipFunc(itmIndex):
	player.equip(itmIndex)
func infoFunc(itmIndex):
	pass
func cancelFunc(itmIndex):
	pass

func _ready():
	btns[0].grab_focus()

func next():
	currIndex += 1
	currIndex = currIndex%3
	btns[currIndex].grab_focus()

func previous():
	currIndex -=1
	currIndex = currIndex%3
	btns[currIndex].grab_focus()

func click():
	var funcs = [equipFunc, infoFunc, cancelFunc]
	funcs[currIndex].call($"..".focusIndex)


func _on_visibility_changed() -> void:
	if visible:
		btns[0].grab_focus()
		if player.equipedItemIndex == $"..".focusIndex:
			btns[0].text = "Unequip"
		else:
			btns[0].text = "Equip"
	else:
		$"..".updateFocus()
