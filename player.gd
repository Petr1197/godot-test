extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vel = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		vel.x += 1
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		
	if vel.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = vel.x < 0
	
	if vel.x < 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	
	if vel.length() > 0:
		vel = vel.normalized() * speed
		position += vel * delta
		$AnimatedSprite2D.play()
	else: 
		$AnimatedSprite2D.stop()
	position = position.clamp(Vector2.ZERO, screen_size)
	pass
