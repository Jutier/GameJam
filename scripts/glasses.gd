extends Node2D

@export_enum('strength', 'malleability', 'cost', 'mass') var gType: int

var player_inside = false
var pickedUp = false
@onready var viewrect = get_viewport().get_visible_rect()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interaction_zone_body_entered(body):
	if body.has_method("interact"):
		player_inside = body
		player_inside.in_range.append(self)

func _on_interaction_zone_body_exited(body):
	if body.has_method("interact"):
		player_inside.in_range.erase(self)
		player_inside = false

func pickUp(body):
	pickedUp = body
	self.position = viewrect.end - Vector2(70, 70)
	self.scale = Vector2(0.8, 0.8)

func dropDown():
	self.position = pickedUp.position
	self.scale = Vector2(1, 1)
	pickedUp = false
	
func oculus():
	pass
