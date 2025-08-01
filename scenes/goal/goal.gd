extends Area2D

var timer: Node

func _ready() -> void:
	timer = get_tree().get_first_node_in_group("timer")

func _on_body_entered(body: Node2D) -> void:
	timer.stop()
