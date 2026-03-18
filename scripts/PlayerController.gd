extends RigidBody2D

const PLAYER_SPEED = 200.0
var move: Vector2
var lineIndex = 0
var isTalking = false
var talkingNpc = null
var canMove = true

@onready var sprite = $AnimatedSprite2D
@onready var gm = $".."
@onready var dialogBox = $"../Camera2D/Control/DialogBox"


func _physics_process(delta: float) -> void:
	canMove = not isTalking
	if canMove:
		move_and_collide(move * PLAYER_SPEED * delta)
	
func _input(event: InputEvent) -> void:
	if canMove:
		move = Input.get_vector("left", "right", "up", "down")
		if move != Vector2.ZERO:
			rotation = atan2(move.y, move.x) - PI / 2
		if move != Vector2.ZERO:
			sprite.animation = "walk"
			sprite.play()
		else:
			sprite.animation = "default"
	else:
		sprite.animation = "default"
	if event.is_action_pressed("interact") and isTalking:
		dialogBox.displayText(talkingNpc)


func initDialog(npc):
	lineIndex = 0
	isTalking = true
	talkingNpc = npc
	dialogBox.displayText(npc)
