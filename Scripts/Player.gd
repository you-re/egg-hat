extends RigidBody2D

# Default jump speed
var jump_speed = 2500
# Default movement speed
var mov_speed = 50
# Initial x speed
var speed_x = 0
# Drag multiplier - lowers the x speed by drag% each tick
var drag = 0.9
var max_speed = 600
var still_speed = 50
var boost = false
var combo = 0

# Viewport size
var viewport_size # = Vector2(1080, 1920)

# Spawn position
@export var spawn_pos = Vector2(0, 800)

# Controlls
var left = false
var right = false

# Textures
var sprite
var tex_still = load("res://Textures/Kevin_standingStill.png")
var tex_run = load("res://Textures/Kevin_runR.png")

# World scene
var world = preload("res://Scenes/World.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "Player"
	# Set spawn position
	position = spawn_pos
	# Get the viewport size
	viewport_size = get_viewport_rect().size
	# Get the sprite node
	sprite = get_node("Sprite2D")
	# Start the physics
	set_physics_process(true)
	pass # Replace with function body.

# Need to adapt physics to react to time delta
func _physics_process(delta):
	# Get the inputs
	left = Input.is_action_pressed("ui_left")
	right = Input.is_action_pressed("ui_right")
	
	# Key press logic
	if left and right:
		pass
	elif left:
		speed_x -= mov_speed
		speed_x = max(speed_x, -max_speed)
	elif right:
		speed_x += mov_speed
		speed_x = min(speed_x, max_speed)
	# Drag
	else: 
		speed_x *= drag
	
	# -- Sprite orientation and stand still logic --
	# Check if player is moving slower than the still treshold
	if abs(speed_x) < still_speed:
		sprite.texture = tex_still
		sprite.set_flip_h(false)
		speed_x = 0
	# Check if player is moving right
	elif speed_x > still_speed:
		sprite.texture = tex_run
		sprite.set_flip_h(false)
	# Else the player is moving left
	else:
		sprite.texture = tex_run
		sprite.set_flip_h(true)
	
	# Set the linear velocity
	set_linear_velocity(Vector2(speed_x, linear_velocity.y))
	
	if linear_velocity.y > 0:
		set_angular_velocity(0)
		rotation = rotation * 0.5
	
	# Modulo the x-position so the player can wrap
	position.x = (int((position.x + viewport_size.x * 1.5) * 1000) % int(viewport_size.x * 1000)) / 1000 - viewport_size.x * 0.5
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func  collision(collider):
	# Get up input
	if Input.is_action_just_pressed("ui_up"):
		boost = true
			
	var rot = -1
	if 0 < linear_velocity.x:
		rot = 1
	
	# print("collision!")
	if collider.is_in_group("platforms") and linear_velocity.y > 0 and boost:
		var combo_boost = 1.5 + 0.5 * combo
		
		set_linear_velocity(Vector2(linear_velocity.x, -jump_speed * combo_boost))
		set_angular_velocity(30 * rot)
		combo += 1 
		boost = false
		
	elif collider.is_in_group("platforms") and linear_velocity.y > 0:
		set_linear_velocity(Vector2(linear_velocity.x, -jump_speed))
		combo = 0
	else:
		pass
		
	# print(boost)
	pass # Replace with function body.
