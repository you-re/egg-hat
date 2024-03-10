extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func picked_up(body):
	print("Picking up!")
	if body.is_in_group("Player"):
		queue_free()
	pass # Replace with function body.
