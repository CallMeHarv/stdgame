extends CharacterBody2D



var health = 100.0
var enemy_damage = 10.0
@onready var timer: Timer = $Timer
@onready var game_over: Label = $game_over


@onready var progress_bar: ProgressBar = $Health/ProgressBar


func damage() -> void:
	health -= enemy_damage
	progress_bar.value = health
	
func _physics_process(_delta: float) -> void:
	if health <= 0:
		print("no health!")
		timer.start()
		game_over.show()
		queue_free()
		


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
