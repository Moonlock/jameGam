extends Node2D

var enemy_array = []
var am_built = false;
var enemy

func _physics_process(delta):
	if enemy_array.size() != 0 and am_built:
		select_enemy()
		turn()
	else:
		enemy = null

func turn():
	#var enemy_position = get_global_mouse_position()
	get_node("Monster").look_at(enemy.position)

func select_enemy():
	var enemy_progress = []
	for i in enemy_array:
		enemy_progress.append(i.offset)
	var max_offset = enemy_progress.max()
	var enemy_index = enemy_progress.find(max_offset)
	enemy = enemy_array[enemy_index]

func _on_range_body_entered(body: Node2D) -> void:
	enemy_array.append(body.get_parent())

func _on_range_body_exited(body: Node2D) -> void:
	enemy_array.erase(body)
