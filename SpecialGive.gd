class_name SpecialGive extends Command

const specialGivePrefab = preload("res://assets/prefabs/newItem.tscn")

func _init() -> void:
	argNames = ["itemId"]
	id = "specialgive"

func task(args, root):
	if args.size() == 0:
		return false
	var playAnim = true
	if args.size() > 1:
		playAnim = args[1] == "1"
	print("this is called, the arg is " + args[0])
	assert(args[0] in root.itemRegistry.items.keys())
	var itm = root.itemRegistry.items[args[0]].duplicate()
	root.get_node("Player").addItem(itm)
	if playAnim:
		var instance = specialGivePrefab.instantiate()
		instance.get_node("Item").texture = itm.inventorySprite
		root.get_node("Camera2D/Control").add_child(instance)
	return true
