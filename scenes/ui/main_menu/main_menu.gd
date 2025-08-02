extends Control

const firebaseConfig = {
	"apiKey": "AIzaSyB0OgCArqahNojA1Mbzk4-i1uD2eKyNLtM",
	"authDomain": "leaderboard-dfaff.firebaseapp.com",
	"projectId": "leaderboard-dfaff",
	"storageBucket": "leaderboard-dfaff.firebasestorage.app",
	"messagingSenderId": "208501402307",
	"appId": "1:208501402307:web:d92c6ef59efaaf08f75076",
	"databaseURL": "https://leaderboard-dfaff-default-rtdb.firebaseio.com/"
};


func _ready() -> void:	
	$MainMenuContainer/Play.grab_focus()
	
	#Leaderboard
	FirebaseLite.initialize(firebaseConfig)
	
	var data = await FirebaseLite.RealtimeDatabase.read("leaderboard/score")
	
	# Player record
	SaveLoad._load()
	var record = SaveLoad.content_to_save.record
	
	var leaderboard = data
	
	if leaderboard == null:
		leaderboard = []
		for i in range(0, 9):
			leaderboard.append(99.999)
	
	if record && !leaderboard.has(record):
		leaderboard.append(record)
		leaderboard.sort()
		leaderboard = leaderboard.slice(0, 9)
	
	var data_send = {}
	
	var i = 1
	for time in leaderboard:
		var msec = fmod(time, 1) * 1000
		var sec = fmod(time, 60)
		var time_string = "%02d : %03d" % [sec, msec]
		var label = get_node("LevelSelectionContainer/ScoreContainer/MarginContainer/VBoxContainer/ScoreLabel%d" % i)
		label.text = time_string
		var color = "ffffff"
		if time == record:
			color = "ecbf00"
		label.set("theme_override_colors/font_color", color)
			
		data_send[i-1] = time
		i += 1
	
	# Personal best
	var msec = fmod(record, 1) * 1000
	var sec = fmod(record, 60)
	get_node("LevelSelectionContainer/ScoreContainer/MarginContainer/VBoxContainer/MarginContainer2/PBLabel").text = "PB : %02d : %03d" % [sec, msec]
		
	FirebaseLite.RealtimeDatabase.write("leaderboard/score", data_send)
	
func _on_play_pressed() -> void:
	$MainMenuContainer.visible = false
	$LevelSelectionContainer.visible = true
	$LevelSelectionContainer/LevelContainer/VBoxContainer/Run.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_back_pressed() -> void:
	$LevelSelectionContainer.visible = false
	$MainMenuContainer.visible = true
	$MainMenuContainer/Play.grab_focus()
