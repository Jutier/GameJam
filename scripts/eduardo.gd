extends CharacterBody2D

const VELOCIDADE_NORMAL = 50
const VELOCIDADE_CORRENDO = 150
const ACELERACAO = 750
const FRICCAO = 750
const TEMPO_CAIDO = 120
const ESTAMINA_MAXIMA = 300

var estamina = ESTAMINA_MAXIMA
var caido = TEMPO_CAIDO
var sentido = [0, 1]

@onready var animação = get_node("animação")

func _physics_process(delta):
	
	var shiftPressionado = Input.is_key_pressed(KEY_SHIFT)
	var entrada = pega_entrada()


	if estamina < ESTAMINA_MAXIMA and not (shiftPressionado or caido < TEMPO_CAIDO):
		estamina += 1
	
	if entrada != Vector2.ZERO and caido == TEMPO_CAIDO:
		sentido = [velocity.x, velocity.y] # CONFIA
		
		if shiftPressionado:
			animação.play("idle_left")
			if estamina > 0:
				corre(delta, entrada)
			else:
				cansado()
		else:
			animação.play("idle_right")
			anda(delta, entrada)
			
	else:
		if caido < TEMPO_CAIDO:
			caido += 1
			
		velocity = velocity.move_toward(Vector2.ZERO , FRICCAO * delta)
		
	anima(velocity.length()) # CONFIA
	move_and_slide()

func corre(delta, entrada):
	velocity = velocity.move_toward(entrada * VELOCIDADE_CORRENDO, ACELERACAO * delta)
	estamina -= 1

func anda(delta, entrada):
	velocity = velocity.move_toward(entrada * VELOCIDADE_NORMAL, ACELERACAO * delta)

func cansado():
	caido = 0

func pega_entrada():
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

	animação.play(linha)
