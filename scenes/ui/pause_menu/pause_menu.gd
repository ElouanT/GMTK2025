extends Control

func _on_return_pressed() -> void:
	hide()
	Engine.time_scale = 1

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
