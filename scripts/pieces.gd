extends Node2D

#@export_group("Parts Properties")
@export_enum('0', '1', '2') var strength: int
@export_enum('0', '1', '2') var malleability: int
@export_enum('0', '1', '2') var cost: int
@export_enum('0', '1', '2') var mass: int

const SHADOWS = ['#80e5ff', '#eaff80', '#ff80df']
@onready var props = [strength, malleability, cost, mass]

@onready var viewrect = get_viewport().get_visible_rect()

var player_inside = false
var pickedUp = false
@onready var Dudu = $"../eduardo"

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.connect("glasses_on_signal", _on_eduardo_glasses_on_signal)
	SignalManager.connect("glasses_off_signal", _on_eduardo_glasses_off_signal)
	
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

func _on_eduardo_glasses_on_signal(gType):
	self.modulate = Color(SHADOWS[props[gType]])


func _on_eduardo_glasses_off_signal():
	self.modulate = Color('#ffffff')

func rocketP():
	pass
