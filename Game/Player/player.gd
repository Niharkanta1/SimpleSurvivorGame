#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name Player

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var healh_bar_ui: ProgressBar = $HealthBarUI

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

var colliding_body_count = 0


func _ready() -> void:
	update_health_bar_ui()


func _physics_process(delta: float) -> void:
	var move_vector = get_movement_vector()
	var dir = move_vector.normalized()
	var target_velocity = dir * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	move_and_slide()


func check_deal_damage() -> void:
	if colliding_body_count == 0 or !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


func get_movement_vector() -> Vector2:
	return Input.get_vector("left", "right", "up", "down")


func update_health_bar_ui() -> void:
	healh_bar_ui.value = health_component.get_health_percent()


func _on_collision_area_body_entered(body: Node2D) -> void:
	colliding_body_count += 1
	check_deal_damage()


func _on_collision_area_body_exited(body: Node2D) -> void:
	colliding_body_count -= 1
	

func _on_damage_interval_timer_timeout() -> void:
	check_deal_damage()


func _on_health_component_health_changed() -> void:
	update_health_bar_ui()
