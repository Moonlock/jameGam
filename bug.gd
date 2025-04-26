extends CharacterBody2D

@onready var _follow :PathFollow2D = get_parent()
var _last_progress = 0
@export var _speed :float = 120.0
@export var _health = 10

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)
	var new_progress = _follow.get_progress()
	if new_progress < _last_progress:
		print("Take damage")
		get_parent().get_parent().queue_free()
	_last_progress = new_progress
	


func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	body.despawn()
	
	_health -= body.damage()
	if _health <= 0:
		queue_free()
