class_name Bullet extends CharacterBody2D

@export var _damage = 5
@export var _speed = 400
var _direction = Vector2.RIGHT

func damage():
	return _damage
	
func set_direction(rotation):
	_direction = Vector2.RIGHT.rotated(rotation)
	
func handleHit():
	queue_free()

func _physics_process(delta):
	position += _direction * delta  * _speed
