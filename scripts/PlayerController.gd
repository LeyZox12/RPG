extends RigidBody2D

const NO_ITEM = -1
const PLAYER_SPEED = 200.0
var move: Vector2
var lineIndex = 0
var isTalking = false
var talkingNpc = null
var canMove = true
var isInventory = false
var disableInput = false
var equipPrompt = false
var equipedItemIndex = NO_ITEM

@onready var sprite = $AnimatedSprite2D
@onready var gm = $".."
@onready var dialogBox = $"../Camera2D/Control/Dialog/DialogBox"
@onready var prompt = $"../Camera2D/Control/Inventory/Prompt"
@onready var inventoryUI = $"../Camera2D/Control/Inventory"

var inventory = []

func _physics_process(delta: float) -> void:
	canMove = not isTalking and not isInventory

	if canMove:
		if move != Vector2.ZERO:
			rotation = atan2(move.y, move.x) - PI/2.0
		move_and_collide(move * PLAYER_SPEED * delta)
	
func _input(event: InputEvent) -> void:
	if disableInput:
		return
	move = Input.get_vector("left", "right", "up", "down")
	if canMove:
		if move != Vector2.ZERO:
			sprite.animation = "walk"
			sprite.play()
		else:
			sprite.animation = "default"
	else:
		sprite.animation = "default"
	
	if not canMove:
		var obj = prompt if equipPrompt else inventoryUI
		if event.is_action_pressed("up"):
			obj.previous()
		elif event.is_action_pressed("down"):
			obj.next()
	
	if not isTalking and event.is_action_pressed("inventory"):
		isInventory = not isInventory
		inventoryUI.visible = isInventory
		
		
	if event.is_action_pressed("confirm") and isInventory:
		if equipPrompt:
			inventoryUI.get_node("Prompt").click()
			equipPrompt = false
			prompt.visible = false
		else:
			equipPrompt = true
			prompt.visible = true
		
	if event.is_action_pressed("interact") and isTalking:
		dialogBox.displayText(talkingNpc)

func addItem(item):
	inventory.push_back(item)
	var l = Button.new()
	l.text = item.displayName
	l.set_meta("id", item.id)
	inventoryUI.get_node("VBoxContainer").call_deferred("add_child", l)


func initDialog(npc):
	lineIndex = 0
	isTalking = true
	talkingNpc = npc
	dialogBox.displayText(npc)
