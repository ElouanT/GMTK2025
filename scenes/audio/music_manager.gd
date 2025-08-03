extends Node2D

@export var loop_start: float
@export var loop_end: float
var audio_stream: AudioStreamPlayer

func _ready() -> void:
	audio_stream = $AudioStreamPlayer
	audio_stream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var position = audio_stream.get_playback_position() + AudioServer.get_time_since_last_mix()
	if (position >= loop_end):
		audio_stream.seek(loop_start)
