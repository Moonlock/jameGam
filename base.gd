extends Sprite2D

@export var _health = 10

func _ready():
	SignalManager.connect("take_damage", take_damage)
	
func take_damage():
	_health -= 1
	if _health == 0:
		SignalManager.emit_signal("game_over")
