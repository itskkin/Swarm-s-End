extends CharacterBody2D

# Onready variables
@onready var anim_tree = get_node("AnimationTree")
@onready var animated_sprite = $AnimatedSprite2D # Replace with the actual path if necessary

# Exported variables
@export var projectile_node: PackedScene
@onready var enemy = get_tree().current_scene.find_child("Enemy")
#Wizzard Health 
#setter variable to update progress bar 
var health : float = 100:
	set(value):
		health = value
		%Health.value = value
#Storing enemy nodes and separation5
var nearest_enemy : CharacterBody2D 
var nearest_enemy_distance : float = INF

# Instance variables
var attacking = false


	
# Shooting functions
func single_shot(animation_name = "fire",  damage: float = 10.0):
	var projectile = projectile_node.instantiate()
	projectile.play(animation_name)
	projectile.position = global_position
	projectile.direction = (get_global_mouse_position() - global_position).normalized()
	projectile.damage = damage
	get_tree().current_scene.call_deferred("add_child", projectile)


func multi_shot(count: int = 3, delay: float = 0.3, animation_name = "fire",  damage: float = 10.0):
	for i in range(count):
		single_shot(animation_name, damage)
		await get_tree().create_timer(delay).timeout
		
func angle_shot(angle, i,  damage: float = 10.0):
	var projectile = projectile_node.instantiate()
	projectile.play("fire" if i % 2 == 0 else "Tornado")
	projectile.position = global_position
	projectile.direction = Vector2(cos(angle), sin(angle))
	projectile.damage =  damage
	get_tree().current_scene.call_deferred("add_child", projectile)
	

func radial(count,  damage: float = 10.0):
	for i in range(count):
		var angle = (float(i) / count) * 2.0 * PI
		angle_shot(angle, i, damage)
	
func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	var character_position = global_position
	
	#if nearest_enemy is not null, store its separation 
	#else set default value which is infinite
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
		#print(nearest_enemy.name)
	else:
		nearest_enemy_distance = INF



	# Handle attack input
	if Input.is_action_just_pressed("shoot"):
		anim_tree.get("parameters/playback").travel("Attack")
		attacking = true
	else:
		# Movement input
		var input_vector = Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		).normalized()

		# Update velocity
		velocity = input_vector * 300 # Adjust speed multiplier as needed
		
		# Move the character
		move_and_slide()

		# Animation logic
		if input_vector == Vector2.ZERO:
			anim_tree.get("parameters/playback").travel("Idle")
		else:
			anim_tree.get("parameters/playback").travel("Walk")
			anim_tree.set("parameters/Idle/BlendSpace1D/blend_position", input_vector)
			anim_tree.set("parameters/Walk/BlendSpace1D/blend_position", input_vector)
			anim_tree.set("parameters/Attack/BlendSpace1D/blend_position", input_vector)

		# Handle flipping logic
		if Input.is_action_pressed("move_left"):
			animated_sprite.flip_h = true
		elif Input.is_action_pressed("move_right"):
			animated_sprite.flip_h = false
		else:
			# Fallback to mouse-based flipping
			animated_sprite.flip_h = mouse_position.x < character_position.x

# Animation finished callback
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Attack" in anim_name:
		attacking = false
		
#function to reduce health
func take_damage(amount):
		health -= amount
	#print(amount)

#Reduce Health with enemy's damage
func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

#disable & enable with eacth timeout
func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
