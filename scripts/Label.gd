extends Label



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.text = var_to_str(get_parent().get_node("eduardo").stamina)
	self.text += '\n'
	self.text += var_to_str(get_parent().get_node("eduardo").tired)
	self.text += '\n'
	#self.text += var_to_str(get_parent().get_node("item").pickedUp)
	#get_parent().get_node('Debug Label').text = var_to_str(get_parent().get_node("item").player_inside)
	

