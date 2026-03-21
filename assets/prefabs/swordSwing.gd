extends RigidBody2D

@export var animLength = 0.6
@export var deltaTheta = 90
@export var damage = 5

func _ready() -> void:
	$Timer.wait_time = animLength
	$Timer.start()

func _physics_process(delta: float) -> void:
	rotate(deltaTheta * (delta / animLength))

func _on_timer_end():
	queue_free()


func _on_body_entered(body: Node) -> void:
	if "canTakeDamage" in body.get_meta_list():
		body.damage()
