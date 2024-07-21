extends CharacterBody2D

const VELOCIDADE_NORMAL= 120
const VELOCIDADE_CORRENDO= 150
const ACELERACAO = 750
const FRICCAO = 750
var momento = Vector2.ZERO

func _physics_process(delta):
	var entrada = Vector2.ZERO
	var shiftPressionado = Input.is_key_pressed(KEY_SHIFT)
	var velocidadeDudu = VELOCIDADE_CORRENDO if shiftPressionado else VELOCIDADE_NORMAL
	
	entrada.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	entrada.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	entrada = entrada.normalized()
	# se a stamina acabar e continuar correndo o player cai e fica 0.5 segundos sem andar
	
	if entrada != Vector2.ZERO:
		momento = momento.move_toward(entrada * velocidadeDudu, ACELERACAO * delta)
	else:
		momento = momento.move_toward(Vector2.ZERO , FRICCAO * delta)
		
	move_and_collide(momento * delta)
