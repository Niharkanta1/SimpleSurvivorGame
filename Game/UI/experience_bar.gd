#
# @auther	Nihar
# @company	DeadW0Lf Games
#

extends CanvasLayer

@export var exeperience_manager: ExperienceManager

@onready var progress_bar = $MarginContainer/ProgressBar

func _ready() -> void:
	progress_bar.value = 0
	exeperience_manager.experience_updated.connect(_on_experience_updated)


func _on_experience_updated(current_experience: float, target_experience: float) -> void:
	var percent = current_experience / target_experience
	progress_bar.value = percent
