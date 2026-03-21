extends RigidBody2D

const PLAYER_SPEED = 200.0
var move: Vector2
var lineIndex = 0
var isTalking = false
var talkingNpc = null
var canMove = true
var isInventory = false
var disableInput = false

@onready var sprite = $AnimatedSprite2D
@onready var gm = $".."
@onready var dialogBox = $"../Camera2D/Control/Dialog/DialogBox"
@onready var inventoryUI = $"../Camera2D/Control/Inventory"

var inventory = []

func _physics_process(delta: float) -> void:
	canMove = not isTalking and not isInventory
	if move != Vector2.ZERO:
		rotation = atan2(move.y, move.x) - PI/2.0
	if canMove:
		move_and_collide(move * PLAYER_SPEED * delta)
	
func _input(event: InputEvent) -> void:
	if disableInput:
		return
	if canMove:
		move = Input.get_vector("left", "right", "up", "down")
		
		if move != Vector2.ZERO:
			sprite.animation = "walk"
			sprite.play()
		else:
			sprite.animation = "default"
	else:
		sprite.animation = "default"
	if not isTalking and event.is_action_pressed("inventory"):
		isInventory = not isInventory
		inventoryUI.visible = isInventory
		
		
	if event.is_action_pressed("interact") and isTalking:
		dialogBox.displayText(talkingNpc)

func addItem(item):
	inventory.push_back(item)
	var l = Label.new()
	l.text = item.displayName
	inventoryUI.get_node("VBoxContainer").call_deferred("add_child", l)


func initDialog(npc):
	lineIndex = 0
	isTalking = true
	talkingNpc = npc
	dialogBox.displayText(npc)
