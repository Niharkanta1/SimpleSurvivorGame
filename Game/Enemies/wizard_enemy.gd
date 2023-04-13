#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name WizardEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component := $VelocityComponent as VelocityComponent

var is_moving: bool

func _physics_process(delta: float) -> void:
	if is_moving:
		velocity_component.accelerate_to_player()
	else:
		velocity_component.decelerate()
	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)

func set_is_moving(moving: bool) -> void:
	is_moving = moving

