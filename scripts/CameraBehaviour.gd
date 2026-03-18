extends Camera2D

@onready var target = $"../Player"

func _process(delta: float) -> void:
	position = target.position
