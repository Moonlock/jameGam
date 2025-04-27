class_name Bullet extends CharacterBody2D

@export var _damage = 5
@export var _speed = 400

func damage():
	return _damage
	
func handleHit():
	queue_free()

func _physics_process(delta):
	position += Vector2.RIGHT * delta  * _speed
