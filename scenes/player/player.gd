extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -800.0
#Variable pour gérer les sauts muraux et ne pas rester coller contre le mur
var can_move := true
var can_dash := true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 2.5 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or is_on_floor():
			can_move = true

	var direction := Input.get_axis("left", "right")
	if direction and can_move :
		if velocity.x > SPEED or velocity.x < -SPEED:
			velocity.x = move_toward(velocity.x , direction * SPEED, 20)
		else:
			velocity.x = direction * SPEED
	else:
	# Inertie au sol et en l'air
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, 40)
		else:
			velocity.x = move_toward(velocity.x, 0, 7)
	
	# Wall jump
	var opposite_direction := Input.get_axis("right", "left")
	if Input.is_action_just_pressed("jump") and not is_on_floor() and is_on_wall():
		can_dash = true
		velocity.y = JUMP_VELOCITY
		if Input.is_action_pressed("left"):
				velocity.x = SPEED
				can_move = false
		elif Input.is_action_pressed("right"):
				velocity.x = -SPEED
				can_move = false
		
	#dash
	var direction_updown = Input.get_axis("up", "down")
	if Input.is_action_just_pressed("dash") and can_dash and !(is_on_floor() || is_on_wall()):
		dash(direction, direction_updown)
	if  Input.is_action_just_pressed("dash") && Input.is_action_pressed("jump") && can_dash && !is_on_wall():
		dash(direction, direction_updown)
	if  Input.is_action_just_pressed("jump") && Input.is_action_pressed("dash") && can_dash:
		dash(direction, direction_updown)
	if is_on_floor():
		can_dash = true

	move_and_slide()

func dash(direction, direction_updown):
	velocity.x = 2.5 * direction * SPEED
	velocity.y = 2.5 * direction_updown * SPEED
	can_dash = false
