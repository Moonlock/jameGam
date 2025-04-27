extends TileMapLayer

func _ready() -> void:
	SignalManager.connect("tower_in_hand", _tower_in_hand)
	SignalManager.connect("tower_placed", _tower_placed)
		
func _tower_in_hand():
	# show area where tower can be placed
	$Polygon2D.show()
	$Polygon2D2.show()
	
func _tower_placed():
	$Polygon2D.hide()
	$Polygon2D2.hide()

func _on_tower_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("ui_accept"):
		# send signal to place tower button to place tower if in hand
		SignalManager.emit_signal("tower_area_clicked", event)
