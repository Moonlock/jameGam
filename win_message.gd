extends Label

func _ready():
	SignalManager.connect("win", show_message)
	
func show_message():
	visible = true
