extends Button

@onready var fire_tower = load("res://fire_tower.tscn")
var _selected_tower

func _ready():
	SignalManager.connect("tower_selected", tower_selected)
	
func tower_selected(tower):
	disabled = false
	_selected_tower = tower

func _on_pressed() -> void:
	position = _selected_tower.position
	_selected_tower.queue_free()
	
	var upgraded = fire_tower.instantiate()
	upgraded.position = position
	get_parent().get_parent().add_child(upgraded)
	
