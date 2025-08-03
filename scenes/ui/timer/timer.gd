extends Node

var time = 0.0
var stopped = false

var record = 0

func _ready() -> void:
	reset()
	SaveLoad._load()
	record = SaveLoad.content_to_save.record
	
func _process(delta: float) -> void:
	if stopped:
		return
	
	if time < 59.999:
		time += delta
	else:
		time = 59.999
	
func start():
	reset()
	stopped = false

func stop():
	stopped = true
	
	# update si le record est battu
	if record == 0 || time < record:
		record = int(time * 1000) / 1000.0
		SaveLoad.content_to_save.record = record
		SaveLoad._save()
		
	
func reset():
	time = 0.0
	
func get_time() -> String:
	return time_to_string(time)
	
func time_to_string(time: float) -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var time_string = "%02d : %03d" % [sec, msec]
	return time_string
	
