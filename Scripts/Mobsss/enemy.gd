extends CharacterBody2D

@export var player_reference : CharacterBody2D

var damage_popup_node = preload("res://Scene/damage.tscn")

var direction : Vector2
var speed : float = 75
var damage : float 
var knockback: Vector2
var separation : float

#enemy's health
var health : float:
	set(value):
		health = value
		if health <=0:
			queue_free()
	
#setter flag variable for elite mobs
var elite : bool = false:
	set(value):
		elite = value
		#if its an elite then set material to the saved material
		if value:
			$Sprite2D.material = load("res://Shader/RedShaders.tres")
			scale = Vector2(1.5,1.5)
			damage += 50
			
#store enemies resource that updates Sprite2D
var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage
		#enemy health from resource
		health = value.health
		
		
#in order to follow the wizzard
#if separation is more than 500 free them from memory (only for normal spawns)
func _physics_process(delta):
	check_separation(delta)
	knockback_update(delta)
	
	
#Calculate separation and store it through a function
func check_separation(_delta):
	separation = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
		
	#if any enemy is nearer, it will update the nearest_enemy from enemy to player
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self
		
#handles the knockback of colliding enemies
func knockback_update(delta):
	velocity = (player_reference.position - position).normalized() * speed
	#knockback will be decaying overtime
	knockback = knockback.move_toward(Vector2.ZERO, 1)
	velocity += knockback
	
	var collider = move_and_collide(velocity * delta)
	#Applying knockback to bodies colliding with the enemy
	if collider:
		collider.get_collider().knockback = (collider.get_collider().global_position -
		global_position).normalized() * 50
	
#damage pop up & add to scene tree
func damage_popup(amount):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount)
	popup.position = position + Vector2(-50,-25)
	get_tree().current_scene.add_child(popup)
	
#enemy taking damage
func take_damage(amount: float):
	if amount > 0:
		damage_popup(amount)
		health -= amount
		print("naaigo ang enemy dog : ", amount)

 
##Not putting hitbox in Enemy node, keeping it lightweight
##Keeping enemy lightweight because hundreds of them are spawning 
