extends Node

var time = 0.0
var stopped = false

func _ready() -> void:
	reset()
	
func _process(delta: float) -> void:
	if stopped:
		return
		
	time += delta
	
func start():
	reset()
	stopped = false

func stop():
	stopped = true
	
func reset():
	time = 0.0
	
func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var time_string = "%02d : %03d" % [sec, msec]
	return time_string
	
