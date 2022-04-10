#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node2D

@export var experience_value: float = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	GameEvents.emit_experience_vial_collected(experience_value)
	queue_free()
