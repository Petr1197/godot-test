extends CharacterBody2D

@export var move_speed: float = 100

func _physics_process(_delta: float) -> void:
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	# Normalize input direction to prevent faster diagonal movement
	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()
	
	# Apply movement (without delta - move_and_slide handles this internally)
	velocity = input_direction * move_speed
	
	# Handle animations
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "Walk"
		
		# Flip sprite based on horizontal direction
		if velocity.x != 0:
			$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "Idle"
	
	$AnimatedSprite2D.play()
	
	# Apply movement
	move_and_slide()
