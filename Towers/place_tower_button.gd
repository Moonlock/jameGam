extends Button

@export var tower_limit = 4
var number_of_towers: int = 0

# preload basic starter tower scene
@onready var tower_scene = preload("res://Towers/monster_tower.tscn")
@onready var tower_image = $TowerImage
@onready var warning_label = $WarningLabel
@onready var tower_placeable_number = $TowerNumber
var tower_in_hand = false

func _ready() -> void:
	SignalManager.connect("tower_area_clicked", _tower_area_clicked)
	tower_placeable_number.text = str(tower_limit - number_of_towers)

func _process(_delta):
	if tower_in_hand:
		var mouse_position = get_viewport().get_mouse_position()
		tower_image.global_position = mouse_position 

func _on_pressed() -> void:
	# spawn transparent sprite of tower image that follows mouse
	if tower_in_hand:
		pass
	else:
		if number_of_towers < tower_limit:
			SignalManager.emit_signal("tower_in_hand")
			number_of_towers += 1
			tower_placeable_number.text = str(tower_limit - number_of_towers)
			tower_in_hand = true
			tower_image.show()
		else:
			warning_label.text = "Tower Limit Reached!"
			warning_label.show()
			var timer = Timer.new()
			add_child(timer)
			timer.wait_time = 1.0
			timer.start()
			timer.timeout.connect(_fade_warning_label)

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept") and tower_in_hand:
		#warning_label.text = "Can't Place Tower Here"
		#warning_label.show()
		#var timer = Timer.new()
		#add_child(timer)
		#timer.wait_time = 1.0
		#timer.start()
		#timer.timeout.connect(_fade_warning_label)
		
func _tower_area_clicked(event):
	if tower_in_hand:
		get_window().set_input_as_handled()
		# place tower at clicked position
		var new_tower = tower_scene.instantiate()
		new_tower.position = event.position
		get_parent().add_child(new_tower)
		tower_image.hide()
		tower_in_hand = false
		SignalManager.emit_signal("tower_placed")
		
func _fade_warning_label():
	warning_label.hide()
