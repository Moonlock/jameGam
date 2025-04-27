extends Node2D

var enemy_array = []
var enemy
var built = true

func _ready() -> void:
	if built:
		self.get_node("Range/CollisionShape2D").get_shape().radius
		

func _physics_process(delta):
	if enemy_array.size() != 0 and built:
		#select_enemy()
		turn()
	else:
		enemy = null
		
func select_enemy():
	pass
	

func turn():
	get_node("Monster").look_at(enemy_array[0].global_position)

func _on_range_body_entered(body: Node2D) -> void:
	enemy_array.append(body)

func _on_range_body_exited(body: Node2D) -> void:
	enemy_array.erase(body)
