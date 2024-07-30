extends Control



func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0, value) # Replace with function body.


func _on_back_button_pressed():
	LoadingScene.transition("res://scenes/mainMenu.tscn")
	
