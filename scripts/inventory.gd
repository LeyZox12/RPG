extends Control

var focusIndex = 0

@onready var items = $VBoxContainer

func next():
	if items.get_child_count() != 1:
		focusIndex += 1
		focusIndex = focusIndex%(items.get_child_count()-1)
		updateFocus()
func previous():
	if items.get_child_count() != 1:
		focusIndex -= 1
		focusIndex = focusIndex%(items.get_child_count()-1)
		updateFocus()
func updateFocus():
	items.get_child(focusIndex+1).grab_focus()
