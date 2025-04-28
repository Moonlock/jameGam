extends "res://Towers/towers.gd"

@onready var bullet = preload("res://bullet.tscn")


func _on_fire_rate_timer_timeout() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.set_direction($Tower.rotation-6)
	bullet_instance.set_direction($Tower.rotation)
	bullet_instance.set_direction($Tower.rotation+6)
	add_child(bullet_instance)
