extends Control

func _ready() -> void:
	$MainMenuContainer/Play.grab_focus()

func _on_play_pressed() -> void:
	$MainMenuContainer.visible = false
	$LevelSelectionContainer.visible = true
	$LevelSelectionContainer/LevelContainer/Level1.grab_focus()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_back_pressed() -> void:
	$LevelSelectionContainer.visible = false
	$MainMenuContainer.visible = true
	$MainMenuContainer/Play.grab_focus()
