extends Node2D

var paused = false
@export var level_start_pos : Node2D

func _ready() -> void:
	Engine.time_scale = 1
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused
		
		if paused:
			$CanvasLayer/PauseMenu.show()
			$CanvasLayer/PauseMenu/VBoxContainer/Return.grab_focus()
			Engine.time_scale = 0
		else:
			$CanvasLayer/PauseMenu.hide()
			Engine.time_scale = 1
			
