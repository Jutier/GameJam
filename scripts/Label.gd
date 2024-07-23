extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_parent().get_node('Debug Label').text = var_to_str(get_parent().get_node("eduardo").direction)

