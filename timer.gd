extends Timer

const MAX_PHASE = 10
@onready var _next_phase_timer = get_node("NextPhaseTimer")
@onready var _path = preload("res://path.tscn")

var _cur_phase = 0

var _bug_limit
var _cur_bugs
var _bugs_left
var _bug
var _final_phase = false
var _game_over = false

var _bugs_left_mutex = Mutex.new()


func _ready():
	SignalManager.connect("bug_died", handle_bug_death)
	SignalManager.connect("game_over", game_over)
	next_phase()

func game_over():
	_game_over = true

func next_phase():
	_cur_phase += 1
	_cur_bugs = 0
	if _cur_phase > MAX_PHASE:
		return
	
	match _cur_phase:
		1:
			phase1_setup()
		2:
			phase2_setup()
		3:
			phase3_setup()
		4:
			phase4_setup()
		5:
			phase5_setup()
		6:
			phase6_setup()
		7:
			phase7_setup()
		8:
			phase8_setup()
		9:
			phase9_setup()
		10:
			phase10_setup()
		_:
			return
	start()
			
func phase1_setup():
	_bug = load("res://basic_bugAnimated.tscn")
	_bug_limit = 3
	_bugs_left_mutex.lock()
	_bugs_left = _bug_limit
	
func phase2_setup():
	_bug = load("res://basic_bugAnimated.tscn")
	wait_time = .5
	_bug_limit = 10
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase3_setup():
	_bug = load("res://armoured_bug.tscn")
	wait_time = 1.5
	_bug_limit = 5
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase4_setup():
	_bug = load("res://basic_bugAnimated.tscn")
	wait_time = 1
	_bug_limit = 7
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase5_setup():
	_bug = load("res://heavy_bug.tscn")
	wait_time = 2
	_bug_limit = 5
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase6_setup():
	_bug = load("res://armoured_bug.tscn")
	wait_time = 2.5
	_bug_limit = 7
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase7_setup():
	_bug = load("res://speedy_bug.tscn")
	wait_time = .25
	_bug_limit = 20
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase8_setup():
	_bug = load("res://basic_bugAnimated.tscn")
	wait_time = 1
	_bug_limit = 10
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase9_setup():
	_bug = load("res://flying_bug.tscn")
	wait_time = .75
	_bug_limit = 12
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	
func phase10_setup():
	_bug = load("res://boss_bug.tscn")
	wait_time = 2
	_bug_limit = 3
	_bugs_left_mutex.lock()
	_bugs_left += _bug_limit
	_final_phase = true
	
func handle_bug_death():
	_bugs_left_mutex.lock()
	_bugs_left -= 1
	if _final_phase and not _bugs_left and not _game_over:
		win()
	
func win():
	SignalManager.emit_signal("win")
	
func _on_timer_timeout() -> void:
	if(_cur_bugs < _bug_limit):
		var path_instance = _path.instantiate()
		var bug_instance = _bug.instantiate()
		bug_instance.rotation = deg_to_rad(90)
		path_instance.get_node("PathFollow2D").add_child(bug_instance)
		add_child(path_instance)
		_cur_bugs += 1
	else:
		if not _final_phase:
			get_node("NextPhaseTimer").start()
		stop()


func _on_next_phase_timer_timeout() -> void:
	next_phase()
