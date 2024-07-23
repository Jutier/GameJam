extends CharacterBody2D

const VELOCIDADE_NORMAL = 50
const VELOCIDADE_CORRENDO = 150
const TEMPO_CAIDO = 120
const ESTAMINA_MAXIMA = 300

var estamina = ESTAMINA_MAXIMA
var caido = TEMPO_CAIDO
var sentido = [0, 1]
 
@onready var animacao = get_node("animacao")

func _physics_process(delta):
	
	var shiftPressionado = Input.is_key_pressed(KEY_SHIFT)
	var entrada = pega_movimento_x_y()


	if estamina < ESTAMINA_MAXIMA and not (shiftPressionado or caido < TEMPO_CAIDO):
		estamina += 1
	
	if entrada != Vector2.ZERO and caido == TEMPO_CAIDO:
		sentido = [velocity.x, velocity.y]
		
		if shiftPressionado:
			animacao.play("idle_left")
			if estamina > 0:
				corre(entrada)
			else:
				cansado()
		else:
			animacao.play("idle_right")
			anda(entrada)
			
	else:
		if caido < TEMPO_CAIDO:
			caido += 1
			
		#define velocidade dos dois eixos como 0 caso nao haja input 
		velocity.x = move_toward(velocity.x, 0, VELOCIDADE_NORMAL)
		velocity.y = move_toward(velocity.y, 0, VELOCIDADE_NORMAL)
		
	anima(velocity.length())
	move_and_slide()

func corre(entrada):
	velocity = velocity.move_toward(entrada * VELOCIDADE_CORRENDO, VELOCIDADE_CORRENDO)
	estamina -= 1

func anda(entrada):
	velocity = velocity.move_toward(entrada * VELOCIDADE_NORMAL, VELOCIDADE_NORMAL)

func cansado():
	caido = 0

func pega_movimento_x_y():
	var entrada = Vector2.ZERO
	entrada.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	entrada.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	return entrada.normalized()

func anima(modulo_velocidade):
	# CONFIA EM MIM, DEIXA ASSIM, TA PERFEITO
	# as animações eu só testei, ainda n preparei, a juliana ainda vai terminar algumas coisas
	var X = sentido[0]
	var Y = sentido[1]
	var linha = ""
	
	if modulo_velocidade == VELOCIDADE_NORMAL:
		linha += "crawl"
	elif modulo_velocidade == VELOCIDADE_CORRENDO:
		linha += "walk"
	else:
		linha += "idle"
	
	if X == 0:
		if Y < 0:
			linha += "_up"
		else:
			linha += "_down"
	elif X < 0:
		linha += "_right"
	else:
		linha += "_left"

	animacao.play(linha)

func morre():
	queue_free()
