extends Node2D

@export var platform = preload("res://Scenes/Platform.tscn")
@export var cam: Camera2D

# Viewport size
var viewport_size # = Vector2(1080, 1920)

# Distances to spawn the platforms at
var min_ydist = 200
var max_ydist = 500
var min_xdist = 50
var max_xdist = 500
var platforms = []

# Bottom position to check if the bottom platform is outside the camera view
var bottom_platform_pos = 0
# Previous y-spawn position
var ppos = 800
# Platform counter
var counter = 0
# Number of platform instances
var num_instances = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the viewport size
	viewport_size = get_viewport_rect().size
	# Get the camera
	cam = get_node("../Camera2D")
	# Instantiate the firs platform under the player's feet
	var new_platform = platform.instantiate()
	new_platform.position = Vector2(0, ppos)
	# Rename the platform to Platform0
	new_platform.name = "Platform0"
	# Append the platform object to the array
	platforms.append(new_platform)
	# Add the platform as a child to the parent node
	add_child(new_platform)
	# Set the bottom_platform_pos position to the spawn position
	bottom_platform_pos = ppos
	
	# Create the remaining platforms
	for i in range(1, num_instances):
		# Instantiate a new platform
		new_platform = platform.instantiate()
		# Generate new coordinates
		var y_dist = randf_range(min_ydist, max_ydist)
		var x_dist = randf_range(min_xdist, max_xdist)
		# Orient the leaf sprite correctly (must be the first node in platform scene)
		if x_dist > 0:
			new_platform.get_child(0).set_flip_h(true)
		# Update the previous y-spawn position	
		ppos -= y_dist
		# Set the new platform's position
		new_platform.position = (Vector2(x_dist, ppos))
		# Rename the new platform
		new_platform.name = "Platform" + str(i)
		# Append the platform to the platforms collection
		platforms.append(new_platform)
		# Add the platform as a child to the parent node
		add_child(new_platform)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var cam_y_pos = cam.position.y + viewport_size.y / 1.9
	if bottom_platform_pos > cam_y_pos:
		# Generate new positions
		var y_dist = randf_range(min_ydist, max_ydist)
		var x_dist = randf_range(-max_xdist, max_xdist)
		# Set the position
		ppos -= y_dist
		# Get the platform node
		platform = platforms[counter]
		# Change the position of the platform
		platform.position = (Vector2(x_dist, ppos))
		# Orient the leaf sprite correctly (must be the first node in platform scene)
		platform.get_child(0).set_flip_h(false)
		if x_dist > 0:
			platform.get_child(0).set_flip_h(true)
		# Add 1 to the platform counter
		counter = counter % (num_instances - 1) + 1
		# Update the bottom position
		bottom_platform_pos = platforms[counter].position.y
	pass
