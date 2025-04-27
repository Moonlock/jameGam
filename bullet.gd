class_name Bullet extends CharacterBody2D

@export var _damage = 5

func damage():
	return _damage
	
func handleHit():
	print("Normal hit")
	queue_free()
