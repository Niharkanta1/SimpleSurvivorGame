#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name ExperienceManager

signal level_up(new_level: int)
signal experience_updated(current_experience: float, target_experience: float)

var current_experience: float = 0
var current_level: int = 1
var target_experience: float = 5
var target_experience_growth: float = 5

func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_experience(value: float) -> void:
	current_experience = min(current_experience + value, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		target_experience += target_experience_growth
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)


func _on_experience_vial_collected(value: float) -> void:
	increment_experience(value)
