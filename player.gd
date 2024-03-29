extends CharacterBody3D

# Constants
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Building block scenes
var block_sprite = preload("res://block_sprite.tscn")
var block_physical = preload("res://block.tscn")

# Mapping for ease of writing
func parse_action(action : String) -> bool: return Input.is_action_just_pressed(action)

# Other misc variables


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Capture the mouse so there is no cursor on the screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Do the movement
	movement(delta)
	

## Receives input callbacks generated by the engine;
## primarily used for camera movement
func _input(event : InputEvent) -> void:	
	var camera : Camera3D = $Camera3D
	
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x))
		camera.rotate_x(deg_to_rad(-event.relative.y))
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)


## Handles movement in a single function, for clarity
func movement(delta : float) -> void:
	# gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# button inputs that are not WASD
	if parse_action("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if parse_action("exit"):
		get_tree().quit()
	if parse_action("build"):
		var spring = $Camera3D/SpringArm3D
		if not spring.get_child(0):
			spring.add_child(block_sprite.instantiate())
		else:
			spring.get_child(0).queue_free()
	
	# WASD movement
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	# apply velocity
	move_and_slide()
		
func place_blocks():
	pass
	
	
		
		