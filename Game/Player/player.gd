#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CharacterBody2D
class_name Player

@onready var health_component := $HealthComponent as HealthComponent
@onready var velocity_component := $VelocityComponent as VelocityComponent
@onready var damage_interval_timer: Timer = $DamageIntervalTimer
@onready var healh_bar_ui: ProgressBar = $HealthBarUI
@onready var abilities: Node = $Abilities
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var visuals: Node2D = $Visuals

var colliding_body_count = 0
var base_move_speed = 0


func _ready() -> void:
	base_move_speed = velocity_component.max_speed
	update_health_bar_ui()
	GameEvents.ability_upgrade_added.connect(_on_ability_upgrade_added)
	

func _physics_process(delta: float) -> void:
	var move_vector = get_movement_vector()
	var dir = move_vector.normalized()
	velocity_component.accelerate_in_direction(dir)
	velocity_component.move(self)

	if move_vector.x != 0 or move_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	
	var move_sign = sign(move_vector.x)
	if move_sign != 0:
		visuals.scale = Vector2(move_sign, 1)


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
	GameEvents.emit_player_damaged()
	update_health_bar_ui()
	$RandomAudioPlayerComponent.play_random()
	

func _on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary) -> void:
	if upgrade is Ability:
		var ability_controller = (upgrade as Ability).ability_controller_scene.instantiate()
		abilities.add_child(ability_controller)
	elif upgrade.id == "move_speed":
		velocity_component.max_speed = base_move_speed + base_move_speed * current_upgrades["move_speed"]["quantity"] * 0.1
