extends Sprite2D

@onready var _follow :PathFollow2D = get_parent()
var _last_progress = 0
var _speed :float = 120.0

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)
	var new_progress = _follow.get_progress()
	if new_progress < _last_progress:
		print("Take damage")
	_last_progress = new_progress
