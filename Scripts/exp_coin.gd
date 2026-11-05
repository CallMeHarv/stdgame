extends Area2D

@export var amount = 10
@export var coins = 1


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_exp") and body.has_method("earn_coin"):
		body.earn_coin(coins)
		body.get_exp(amount)
		print(str(amount))
		print(str(coins))
		queue_free()
