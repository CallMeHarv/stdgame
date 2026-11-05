class_name Player
extends CharacterBody2D


var speed = 300
var health = 100.0

var experience = 0
var experience_level = 1
var exp_required = 100
var coin_collected = 0
@onready var xp_bar: ProgressBar = $UI/xp_bar
@onready var coin_counter: Label = $UI/coin_counter
@onready var tower_placed: Label = $UI/tower_placed
@onready var timer: Timer = $UI/tower_placed/Timer
@onready var label_up: Label = $"UI/Label Up"

#sword
@onready var sword: Area2D = $Node2D/Sword
@onready var attack_cd: Timer = $Node2D/attack_cd
@onready var icon: Sprite2D = $Node2D/Sword/Icon
@onready var animation_player: AnimationPlayer = $Node2D/Sword/AnimationPlayer



func _ready() -> void:
	xp_bar.value = 0
	xp_bar.max_value = 100
	coin_counter.text = "coins: "

func _process(_delta: float) -> void:
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed

	move_and_slide()
	
	xp_bar.value = experience
	xp_bar.max_value = exp_required
	
	if Input.is_action_just_pressed("Attack"):
		sword.monitoring = true
		icon.show()
		animation_player.play("attack")
		attack_cd.start()
	

func get_exp(amount):
	experience += amount
	
	

func earn_coin(coins):
	# might separate xp and coins
	coin_collected += coins
	coin_counter.text = "coins: " + str(coin_collected)
	
	
	
	if experience >= exp_required:
		experience -= exp_required
		level_up()
	

func level_up():
	experience_level += 1
	exp_required += 50
	label_up.show()
	label_up.text = "Leveled Up!"
	print(experience_level)
	timer.start()

func buy_tower():
	pass


func _on_arrow_tower_pressed() -> void:
	if coin_collected >= Towers.arrow_tower:
		tower_placed.show()
		coin_collected -= Towers.arrow_tower
		coin_counter.text = "coins: " + str(coin_collected)
		tower_placed.text = "Placed Arrow Tower!"
		timer.start()
		print("placed arrow tower")
	else:
		tower_placed.text = "Not enough coins!"
		tower_placed.show()
		timer.start()


func _on_gun_tower_pressed() -> void:
	if coin_collected >= Towers.gun_tower:
		tower_placed.show()
		coin_collected -= Towers.gun_tower
		coin_counter.text = "coins: " + str(coin_collected)
		tower_placed.text = "Placed Gun Tower!"
		timer.start()
		print("placed gun tower")
	else:
		tower_placed.text = "Not enough coins!"
		tower_placed.show()
		timer.start()

func _on_timer_timeout() -> void:
	tower_placed.hide()
	label_up.hide()


func _on_sword_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		print("attacked!")


func _on_attack_cd_timeout() -> void:
	sword.monitoring = false
	icon.hide()
