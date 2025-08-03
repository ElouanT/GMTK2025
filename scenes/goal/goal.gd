extends Area2D

@export var tp_zone: Node

var timer: Node

func _ready() -> void:
	timer = get_tree().get_first_node_in_group("timer")

func _on_body_entered(body: Node2D) -> void:
	if body.can_tp:
		var camera
		for child in body.get_children():
			if child is Camera2D:
				camera = child
					
		body.global_translate(Vector2(tp_zone.position.x-position.x, 0))
		camera.reset_smoothing()
		
		if body.can_score:		
			timer.stop()
			timer.start()


func _on_body_exited(body: Node2D) -> void:
	body.can_tp = true
