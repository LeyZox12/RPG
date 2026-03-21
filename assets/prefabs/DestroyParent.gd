extends Timer

@onready var player = $"../../../../Player"

func _ready():
	player.disableInput = true

func _on_timeout() -> void:
	player.disableInput = false
	$"../".queue_free()
