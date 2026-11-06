extends CharacterBody2D

@export var stats: Resource
@export var player_stat: Resource

@export var main_tower: CharacterBody2D
@export var player: CharacterBody2D
@onready var bullet = preload("res://Scripts/bullet.gd")




func _physics_process(_delta: float) -> void:
	if main_tower:
		var direction = global_position.direction_to(main_tower.global_position)
		velocity = direction * stats.speed
	
	
	move_and_slide()
	
func take_damage():
	var coin_drop = randf_range(1, stats.coin_amount)
	stats.health -= Damages.weapon_damage
	print("-10")
	if stats.health <= 0:
		player_stat.coin_collected += coin_drop
		print("dropped " + str(coin_drop))
		var new_gem = stats.loot.instantiate()
		new_gem.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", new_gem)
		queue_free()
	



func _on_attack_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage()
		print("given damage")
		queue_free()
