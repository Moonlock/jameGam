extends Node2D

var _bug_limit = 10
var _cur_bugs = 1

var bug = load("res://path.tscn")

func _on_timer_timeout() -> void:
	if(_cur_bugs < _bug_limit):
		var bug_instance = bug.instantiate()
		add_child(bug_instance)
		_cur_bugs += 1
