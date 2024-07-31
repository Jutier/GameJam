extends Control

func _on_back_button_pressed():
	self.visible = false


func _on_menu_button_pressed():
	LoadingScene.transition("res://scenes/mainMenu.tscn")
