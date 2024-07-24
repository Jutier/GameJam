extends AnimatedSprite2D

var player_inside = false
var pickedUp = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if pickedUp == true:
		self.position = player_inside.position
	if player_inside and Input.is_action_just_pressed("use"):
		dropDown() if pickedUp else pickUp()
		print('USOU AQUI Ó')

func _on_interaction_zone_body_entered(body):
	if body.has_method("interact"):
		player_inside = body

func _on_interaction_zone_body_exited(body):
	if body.has_method("interact"):
		player_inside = false

func pickUp():
	pickedUp = true
	player_inside.interact(self)

func dropDown():
	pickedUp = false
	#player_inside.holding = false	
