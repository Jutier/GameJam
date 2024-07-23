extends CharacterBody2D

const VELOCIDADE_NORMAL = 50
const VELOCIDADE_CORRENDO = 150
const ACELERACAO = 750
const FRICCAO = 750
const TEMPO_CAIDO = 120
const ESTAMINA_MAXIMA = 300

var estamina = ESTAMINA_MAXIMA
var caido = TEMPO_CAIDO

func _physics_process(delta):
	print(estamina, caido)
	
	var shiftPressionado = Input.is_key_pressed(KEY_SHIFT)
	var entrada = pega_entrada()

	
	if estamina < ESTAMINA_MAXIMA and not (shiftPressionado or caido < TEMPO_CAIDO):
		estamina += 1
	
	if entrada != Vector2.ZERO and caido == TEMPO_CAIDO:
		if shiftPressionado:
			if estamina > 0:
				corre(delta, entrada)
			else:
				cansado()
		else:
			anda(delta, entrada)
			
	else:
		if caido < TEMPO_CAIDO:
			caido += 1
			
		velocity = velocity.move_toward(Vector2.ZERO , FRICCAO * delta)
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
	
