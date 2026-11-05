extends CharacterBody2D

var speed = 70
@export var main_tower: CharacterBody2D
@export var player: CharacterBody2D
@export var loot_scene: PackedScene


func _physics_process(delta: float) -> void:
	if main_tower:
		var direction = global_position.direction_to(main_tower.global_position)
		velocity = direction * speed
	
	
	move_and_slide()
	
func take_damage():
	var new_gem = loot_scene.instantiate()
	new_gem.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", new_gem)
	queue_free()


func _on_attack_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage()
		print("given damage")
		queue_free()
