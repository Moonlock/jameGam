extends CharacterBody2D

@export var _damage = 5

func damage():
	return _damage
	
func despawn():
	queue_free()
