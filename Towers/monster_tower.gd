extends "res://Towers/towers.gd"


@onready var bullet = preload("res://bullet.tscn")
var _is_selected = false

func _on_fire_rate_timer_timeout() -> void:
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_accept"):
		$Line2D.show()
		_is_selected = true
		SignalManager.emit_signal("tower_selected", self)
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and _is_selected:
		$Line2D.hide()
		_is_selected = false
