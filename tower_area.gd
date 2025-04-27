extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_accept"):
		# send signal to place tower button to place tower if in hand
		SignalManager.emit_signal("tower_area_clicked", event)
