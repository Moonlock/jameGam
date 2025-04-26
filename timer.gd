extends Timer

const MAX_PHASE = 10
@onready var _next_phase_timer = get_node("NextPhaseTimer")

var _cur_phase = 0

var _bug_limit
var _cur_bugs
var bug


func _ready():
	next_phase()

func next_phase():
	_cur_phase += 1
	_cur_bugs = 0
	if _cur_phase >= MAX_PHASE:
		return
	
	match _cur_phase:
		1:
			phase1_setup()
		2:
			phase2_setup()
		_:
			return
	start()
			
func phase1_setup():
	bug = load("res://path.tscn")
	_bug_limit = 3
	
func phase2_setup():
	bug = load("res://path.tscn")
	_bug_limit = 10
	
func _on_timer_timeout() -> void:
	if(_cur_bugs < _bug_limit):
		var bug_instance = bug.instantiate()
		add_child(bug_instance)
		_cur_bugs += 1
	else:
		get_node("NextPhaseTimer").start()
		stop()


func _on_next_phase_timer_timeout() -> void:
	next_phase()
