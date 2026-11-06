extends Area2D


@export var stat: Resource
var exp_amount = 10
var coin_amount = 1
################# fix data management #################



func _on_body_entered(body: Node2D) -> void:
	if body.has_method("get_exp") and body.has_method("earn_coin"):
		body.earn_coin(coin_amount)
		body.get_exp(exp_amount)
		print(str(exp_amount))
		queue_free()
