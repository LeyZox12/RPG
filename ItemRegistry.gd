class_name ItemRegistry

var items = {}

func _init():
	registerItem(Sword)

func registerItem(itm):
	var instance = itm.new()
	items[instance.id] = instance
	print("Item " + instance.id + " registered")
	
