class_name SpecialGive extends Command

const specialGivePrefab = preload("res://assets/prefabs/newItem.tscn")

func _init() -> void:
	argNames = ["itemId"]
	id = "specialgive"

func task(args, root):
	if args.size() == 0:
		return false
	print("this is called, the arg is " + args[0])
	var instance = specialGivePrefab.instantiate()
	assert(args[0] in root.itemRegistry.items.keys())
	var itm = root.itemRegistry.items[args[0]]
	instance.get_node("Item").texture = itm.inventorySprite
	root.get_node("Camera2D/Control").add_child(instance)
	root.get_node("Player").addItem(itm)
	
	
	return true
