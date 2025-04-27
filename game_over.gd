extends Label

func _ready():
	SignalManager.connect("game_over", show_message)
	
func show_message():
	visible = true
