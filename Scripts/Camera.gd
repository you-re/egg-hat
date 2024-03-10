extends Camera2D

@export var player_path: NodePath
var player
var player_y = 0

var cam_speed = -100
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(player_path)
	set_process(true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Get player's y position
	player_y = player.position.y
	# If player's y pos is < camera y pos adjust the camera's y pos
	if player_y < position.y:
		position.y = lerp(position.y, player_y, delta * 2)
		
	else:
		position.y += cam_speed * delta
	pass
