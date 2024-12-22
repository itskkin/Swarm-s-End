extends CharacterBody2D

@onready var anim_tree = get_node("AnimationTree")
@onready var animated_sprite = $AnimatedSprite2D # Replace with the actual path if necessary

func _physics_process(delta):
	# Get mouse position and character's global position
	var mouse_position = get_global_mouse_position()
	var character_position = global_position

	# Determine input for movement
	var input_vector = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	).normalized() # Normalize to ensure consistent speed in diagonal movement

	# Update velocity based on input
	velocity = input_vector * 300 # Adjust the multiplier for speed as needed

	# Update animation
	if input_vector == Vector2.ZERO:
		anim_tree.get("parameters/playback").travel("Idle")
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		anim_tree.set("parameters/idle/BlendSpace1D/blend_position", input_vector)
		anim_tree.set("parameters/walk/BlendSpace1D/blend_position", input_vector)

	# Flip logic: Priority to keyboard input
	if Input.is_action_pressed("move_left"):
		animated_sprite.flip_h = true # Face left when pressing "A"
	elif Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false # Face right when pressing "D"
	else:
		# Fallback to mouse-based flipping if no movement keys are pressed
		if mouse_position.x < character_position.x:
			animated_sprite.flip_h = true # Face left
		elif mouse_position.x > character_position.x:
			animated_sprite.flip_h = false # Face right

	# Move the character
	move_and_slide()
