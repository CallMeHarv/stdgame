class_name Player
extends CharacterBody2D

@export var stats: Resource

@export var speed = 300
@export var health = 100.0

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
	
	xp_bar.value = stats.experience
	xp_bar.max_value = stats.exp_required
	
	if Input.is_action_just_pressed("Attack"):
		sword.monitoring = true
		icon.show()
		animation_player.play("attack")
		attack_cd.start()
	

func get_exp(amount):
	stats.experience += amount
	
	

func earn_coin(coins):
	# might separate xp and coins
	stats.coin_collected += coins
	stats.coin_counter.text = "coins: " + str(stats.coin_collected)
	
	
	
	if stats.experience >= stats.exp_required:
		stats.experience -= stats.exp_required
		level_up()
	

func level_up():
	stats.experience_level += 1
	stats.exp_required += 50
	label_up.show()
	label_up.text = "Leveled Up!"
	print(stats.experience_level)
	timer.start()

func buy_tower():
	pass


func _on_arrow_tower_pressed() -> void:
	if stats.coin_collected >= Towers.arrow_tower:
		tower_placed.show()
		stats.coin_collected -= Towers.arrow_tower
		stats.coin_counter.text = "coins: " + str(stats.coin_collected)
		tower_placed.text = "Placed Arrow Tower!"
		timer.start()
		print("placed arrow tower")
	else:
		tower_placed.text = "Not enough coins!"
		tower_placed.show()
		timer.start()


func _on_gun_tower_pressed() -> void:
	if stats.coin_collected >= Towers.gun_tower:
		tower_placed.show()
		stats.coin_collected -= Towers.gun_tower
		stats.coin_counter.text = "coins: " + str(stats.coin_collected)
		tower_placed.text = "Placed Gun Tower!"
		timer.start()
		print("placed gun tower")
	else:
		tower_placed.text = "Not enough coins!"
		tower_placed.show()
		timer.start()
		
	# dictionary for coins and towers

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
