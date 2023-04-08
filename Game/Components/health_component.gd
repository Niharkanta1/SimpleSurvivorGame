#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends Node
class_name HealthComponent

signal died
signal health_changed

@export var max_health: float = 10

var current_health: float


func _ready() -> void:
	current_health = max_health
	

func damage(damage_value: float) -> void:
	current_health = max(current_health - damage_value, 0)
	health_changed.emit()
	Callable(check_death).call_deferred()


func get_health_percent() -> float:
	if max_health <= 0:
		return 0
	return min(current_health / max_health, 1)


func check_death():
	if current_health == 0:
		died.emit()
		owner.queue_free()
