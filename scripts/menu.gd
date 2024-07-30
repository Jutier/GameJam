extends Control

# I was thinking about Dudu apearing in the main menu and delivering some lines,
# like Chloe on dbh, but... on a very low budget
# "Did you hear about the claustrophobic astronaut? He just needed a little space!"

#LoadScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	LoadingScene.transition("res://scenes/level.tscn")


func _on_settings_button_pressed():
	LoadingScene.transition("res://scenes/settings.tscn")
