extends Control

@export var bus_name : String
var bus_index

func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))


func _on_back_button_pressed():
	self.visible = false


func _on_menu_button_pressed():
	LoadingScene.transition("res://scenes/mainMenu.tscn")
