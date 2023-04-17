#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name BasicEnemy

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals: Node2D = $Visuals
@onready var velocity_component := $VelocityComponent as VelocityComponent


func _ready() -> void:
	$HurtBoxComponent.hit.connect(_on_hit)


func _physics_process(delta: float) -> void:
	velocity_component.accelerate_to_player()
	velocity_component.move(self)

	var move_sign = sign(velocity.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


func _on_hit() -> void:
	$HitAudioPlayerComponent.play_random()
