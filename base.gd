extends Sprite2D

@onready var _resource_label = $Resources
@onready var _health_label = $Health

@export var _health = 10
@export var _income = 5
@export var _income_frequency = 1
@export var _new_tower_cost = 100
@export var _tower_upgrade_cost = 150
var _gold = 100

func _ready():
	SignalManager.connect("take_damage", take_damage)
	$ResourceTimer.wait_time = _income_frequency
	$ResourceTimer.start()
	
func take_damage():
	if _health > 0:
		_health -= 1
		_health_label.text = str(_health)
		if _health == 0:
			SignalManager.emit_signal("game_over")
		
func get_gold():
	return _gold
	
func spend(gold):
	_gold -= gold
	_resource_label.text = str(_gold)
	
	if _gold < _tower_upgrade_cost:
		SignalManager.emit_signal("cannot_afford_upgrade")
		if _gold < _new_tower_cost:
			SignalManager.emit_signal("cannot_afford_tower")
	

func _on_resource_timer_timeout() -> void:
	_gold += _income
	_resource_label.text = str(_gold)
	
	if _gold >= _new_tower_cost:
		SignalManager.emit_signal("can_afford_tower")
		if _gold >= _tower_upgrade_cost:
			SignalManager.emit_signal("can_afford_upgrade")
