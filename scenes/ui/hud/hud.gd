extends Control

@export var timer_label: Label
@export var pb_label: Label

var timer: Node

func _ready() -> void:
	timer = get_tree().get_first_node_in_group("timer")

func _process(delta: float) -> void:
	update_timer_label()

func update_timer_label():
	timer_label.text = timer.get_time()
	pb_label.text = timer.pb_string
