#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node


@onready var timer: Timer = $Timer


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
