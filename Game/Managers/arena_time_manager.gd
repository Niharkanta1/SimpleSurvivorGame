#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name ArenaTimeManager

const DIFFICUTLY_INTERVAL = 5

signal arena_difficulty_increased(arena_difficulty: int)

@export var end_screen_scene: PackedScene

@onready var timer: Timer = $Timer

var arena_difficulty = 0
var previous_time = 0


func _ready() -> void:
	previous_time = 0


func _process(delta: float) -> void:
	var next_time_target = timer.wait_time - (arena_difficulty + 1) * 5
	if timer.time_left <= next_time_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)
		

func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
	

func _on_timer_timeout() -> void:
	var screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(screen_instance)
	screen_instance.set_victory()
	MetaProgresion.save()
