extends Timer

const MAX_PHASE = 2
@onready var _next_phase_timer = get_node("NextPhaseTimer")

var _cur_phase = 0

var _bug_limit
var _cur_bugs
var _bug
var _final_phase = false


func _ready():
	next_phase()

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
	_bug = load("res://path.tscn")
	_bug_limit = 3
	
func phase2_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	_final_phase = true
	
func phase3_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase4_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase5_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase6_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase7_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase8_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase9_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func phase10_setup():
	_bug = load("res://path.tscn")
	wait_time = .5
	_bug_limit = 10
	
func win():
	SignalManager.emit_signal("win")
	
func _on_timer_timeout() -> void:
	if(_cur_bugs < _bug_limit):
		var bug_instance = _bug.instantiate()
		add_child(bug_instance)
		_cur_bugs += 1
	else:
		get_node("NextPhaseTimer").start()
		stop()


func _on_next_phase_timer_timeout() -> void:
	if not _final_phase:
		next_phase()
