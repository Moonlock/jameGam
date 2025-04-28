extends "res://Towers/towers.gd"

@onready var bullet = preload("res://fire_bullet.tscn")


func _on_fire_rate_timer_timeout() -> void:
	self._make_bullets(-12)
	self._make_bullets(-6)
	self._make_bullets(0)
	self._make_bullets(6)
	self._make_bullets(12)
	
	
func _make_bullets(angle:float) -> void:
	var bullet_instance = bullet.instantiate()
	bullet_instance.set_direction($Tower.rotation+angle)
	add_child(bullet_instance)
