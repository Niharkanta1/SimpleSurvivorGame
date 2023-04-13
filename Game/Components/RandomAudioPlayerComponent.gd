#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends AudioStreamPlayer2D
class_name RandomAudioPlayerComponent

@export var randomize_pitch = true
@export var streams: Array[AudioStream]
@export var min_pitch: float = 0.9
@export var max_pitch: float = 1.1

func play_random() -> void:
	if streams == null or streams.size() == 0:
		return
	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)
	else:
		pitch_scale = 1
	stream = streams.pick_random()
	play()
