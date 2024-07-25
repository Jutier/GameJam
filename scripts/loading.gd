extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func transition(target):
	$AnimationPlayer.play("Loading") # Remember to change the player animation (Dudu) INSIDE the scene
	await get_tree().create_timer($AnimationPlayer.current_animation_length/4).timeout
	get_tree().change_scene_to_file(target)

