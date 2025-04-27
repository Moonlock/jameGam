class_name Bug extends CharacterBody2D

@onready var _follow :PathFollow2D = get_parent()
@onready var fire_scene = preload("res://fire.tscn")
@onready var bullet_particle_scene = preload("res://bullet_hit_particles.tscn")
@export var _speed :float = 120.0
@export var _health = 10
@export var _fire_interval_sec = 1
@export var _fire_damage = 2

var _last_progress = 0
var _on_fire = false

func catch_fire():
	_on_fire = true
	# add animated fire
	var fire = fire_scene.instantiate()
	fire.rotation = -PI/2
	fire.play("default")
	add_child(fire)
	# add timer for fire damage
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.start()
	timer.timeout.connect(take_fire_damage)
	
func take_fire_damage():
	take_damage(_fire_damage)

func _physics_process(delta):
	_follow.set_progress(_follow.get_progress() + _speed * delta)
	var new_progress = _follow.get_progress()
	if new_progress < _last_progress:
		get_parent().get_parent().queue_free()
	_last_progress = new_progress

func _on_collision_shape_2d_body_entered(body: Node2D) -> void:
	if body is Bullet:
		body.handleHit()
		if _on_fire == false: # aka just regular bullet
			var bullet_particles = bullet_particle_scene.instantiate()
			bullet_particles.emitting = true
			add_child(bullet_particles)
		take_damage(body.damage())
			
func take_damage(damage):
	_health -= damage
	if _health <= 0:
		queue_free()
