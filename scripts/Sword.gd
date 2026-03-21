class_name Sword extends UseableItem

var prefab = preload("res://assets/prefabs/Sword.tscn")

func _init():
	id = "sword"
	displayName = "Sword"
	inventorySprite = load("res://assets/Items/sword.png")
	
func onUse(playerNode):
	var instance = prefab.instantiate()
	instance.global_position = playerNode.global_position
	instance.rotation = playerNode.rotation - deg_to_rad(instance.deltaTheta / 2)
	playerNode.add_child(instance)
	
