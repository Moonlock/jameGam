extends Bullet

@onready var fire_collision = $FireCollision

func _ready():
	_damage = 8

func damage():
	return _damage
	
func handleHit():
	var colliders = fire_collision.get_overlapping_bodies()
	print("Colliders = ", colliders.size())
	for collider in colliders:
		print(collider)
		if collider is Bug:
			collider.catch_fire()
	queue_free()
