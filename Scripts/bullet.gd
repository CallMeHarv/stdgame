extends Area2D

var speed = 400.0
var direction = Vector2.RIGHT
var distance_travelled = 0.0

func _physics_process(delta: float) -> void:
	var movement = direction * speed * delta
	position += movement
	
	distance_travelled += movement.length()
	if distance_travelled > 1500:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
	else:
		body.queue_free()
		
	queue_free()
