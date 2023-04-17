#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Button


func _on_pressed() -> void:
	$UIAudioPlayerComponent.play_random()
