extends Button

@export var tower_limit = 4
var number_of_towers: int = 1

# preload tower scene
@onready var tower_scene = preload("res://Towers/monster_tower.tscn")
@onready var tower_image = $TowerImage
@onready var tower_limit_warning = $TowerLimitWarning
@onready var tower_placeable_number = $TowerNumber
var tower_in_hand = false

func _ready() -> void:
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
			number_of_towers += 1
			tower_placeable_number.text = str(tower_limit - number_of_towers)
			tower_in_hand = true
			tower_image.show()
		else:
			tower_limit_warning.show()

func _unhandled_input(event: InputEvent) -> void:
	# if tower in hand and left click, place tower at mouse location
	if event.is_action_pressed("ui_accept") and tower_in_hand:
		# place tower at clicked position
		var new_tower = tower_scene.instantiate()
		new_tower.position = event.position
		get_parent().add_child(new_tower)
		tower_image.hide()
		tower_in_hand = false
		print(number_of_towers)
