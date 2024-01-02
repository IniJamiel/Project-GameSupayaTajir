extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -1000.0
var DASH_SPEED = SPEED * 50

const gap_close = 800

var ComboString = ""

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_dash = true

func _ready():
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("W") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("S"):
		velocity.y = JUMP_VELOCITY * -5
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_just_pressed("Dash") and can_dash:
		velocity.x = direction * DASH_SPEED  # Set dash velocity
	if Input.is_action_just_pressed("Light"):
		$L1/Collision.disabled = false
		
		velocity.x += gap_close * direction
	move_and_slide()
	$L1/Collision.disabled = true
	
	

