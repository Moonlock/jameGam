extends Bullet

@onready var fire_collision = $FireCollision

func _ready():
	_damage = 8

func damage():
	return _damage
	
func handleHit():
	var colliders = fire_collision.get_overlapping_bodies()
	for collider in colliders:
		if collider is Bug:
			collider.catch_fire()
	queue_free()
