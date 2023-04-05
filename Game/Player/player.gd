#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name Player

const MAX_SPEED = 200

func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	var move_vector = get_movement_vector()
	var dir = move_vector.normalized()
	velocity = dir * MAX_SPEED
	move_and_slide()

func get_movement_vector() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")

