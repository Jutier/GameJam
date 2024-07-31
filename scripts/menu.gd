extends Control

# I was thinking about Dudu apearing in the main menu and delivering some lines,
# like Chloe on dbh, but... on a very low budget
# "Did you hear about the claustrophobic astronaut? He just needed a little space!"
#LoadScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	LoadingScene.transition("res://scenes/level.tscn")


func _on_settings_button_pressed():
	$settings_menu.visible = true


func _on_credits_button_pressed():
	$"button box".visible = false
	$Credits.visible = true


func _on_exit_credits_pressed():
	$"button box".visible = true
	$Credits.visible = false
