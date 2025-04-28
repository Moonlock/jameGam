extends "res://Towers/towers.gd"

@onready var bullet = preload("res://fire_bullet.tscn")


func _on_fire_rate_timer_timeout() -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.set_direction($Tower.rotation-8)
	bullet_instance.set_direction($Tower.rotation-4)
	bullet_instance.set_direction($Tower.rotation)
	bullet_instance.set_direction($Tower.rotation+4)
	bullet_instance.set_direction($Tower.rotation+8)
	add_child(bullet_instance)
