extends CharacterBody2D

const CRAWL_SPEED = 100
const WALK_SPEED = 150
const STUN_DURATION = 120
const MAX_STAMINA = 300

var stamina = MAX_STAMINA
var tired = STUN_DURATION # for lack of a better name, this will have to suffice
var direction = [0, 1] # it needs to be out here, it must not update every frame

#var free = true # must be a way to see if the player is able to use actions (not tired, not holding, etc)
 
@onready var node_animation = get_node("animation")

func _physics_process(_delta):
	
	var sprintPressed = false #Input.is_action_pressed("sprint")
	var xy_input = get_input_xy()


	# recovers stamina if not down or running
	if stamina < MAX_STAMINA and not (sprintPressed or tired < STUN_DURATION):
		stamina += 1
	
	if xy_input != Vector2.ZERO and tired == STUN_DURATION:
		if velocity.x != 0 or velocity.y != 0: # more explicit than .lenght()
			# it just check if velocity is REALLY not zero, somehow the first if was not enough
			direction = [velocity.x, velocity.y]

		if sprintPressed:
			if stamina > 0:
				walk(xy_input)
			else:
				stun()
		else:
			crawl(xy_input)
			
	else:
		if tired < STUN_DURATION:
			# recovers from stun
			tired += 1
			
		# set speed to 0 is there is no input
		velocity.x = move_toward(velocity.x, 0, CRAWL_SPEED)
		velocity.y = move_toward(velocity.y, 0, CRAWL_SPEED)
		
	animate(velocity.length())
	move_and_slide()

func walk(xy_input):
	velocity = velocity.move_toward(xy_input * WALK_SPEED, WALK_SPEED)
	stamina -= 1

func crawl(xy_input):
	velocity = velocity.move_toward(xy_input * CRAWL_SPEED, CRAWL_SPEED)

func stun():
	dropItem()
	#free = false
	tired = 0

func get_input_xy():
	var xy_input = Vector2.ZERO
	xy_input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	xy_input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return xy_input.normalized()

func animate(speed_abs):
	# not the most elegant solution, but sure a fun one
	var X = direction[0]
	var Y = direction[1]
	var label = ""
	
	if speed_abs == CRAWL_SPEED:
		label += "crawl"
	elif speed_abs == WALK_SPEED:
		label += "walk"
	else:
		label += "idle"
	
	if X == 0:
		if Y < 0:
			label += "_up"
		else:
			label += "_down"
	elif X < 0:
		label += "_right"
	else:
		label += "_left"

	node_animation.play(label)

func interact(item):
	pass

func dropItem():
	pass

func dead():
	queue_free()
