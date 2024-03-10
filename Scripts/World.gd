extends Node2D

var player
var viewport_size
var new_game
@export var world = preload("res://Scenes/World.tscn")
var sleep = false

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game = world.instantiate()
	add_child(new_game)
	# Get the viewport size
	viewport_size = get_viewport_rect().size
	player = get_node("World/Player")
	print(player)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Instantiate a new world
	if player == null:
		var game = get_child(0).name
		player = get_node("%s/Player" %[game])
	elif player.position.y > viewport_size.y / 2:
		for child in new_game.get_children():
			child.queue_free()
		new_game.queue_free()
		new_game = world.instantiate()
		# new_game.name = "World"
		add_child(new_game)
	else:
		pass
	pass
