extends State


@export var MAX_HOLD_FRAMES := 30
var hold_frames := 0

func enter() -> void:
	print("Entering Jump State")
	hold_frames = 0 
	parent.velocity.y = - parent.JUMP_STRENGTH
	parent.Animation_Player.play("jump")
	
func exit() -> void:
	parent.current_coyote_frames = 16
	parent.Animation_Player.stop()
	print("Exiting Jump State")
	
func process_physics(delta: float) -> State:
	
	var gravity := parent.get_gravity().y
	var move := Input.get_action_strength("Right") - Input.get_action_strength("Left")
	parent.velocity.x = lerp(parent.velocity.x, move * parent.AIR_SPEED, delta * parent.AIR_ACCEL)
	
	if Input.is_action_pressed("Jump"):
		if hold_frames < MAX_HOLD_FRAMES:
			hold_frames += 1 
			gravity = parent.get_gravity().y / 2
		
	
	if Input.is_action_just_released("Jump"):
		gravity = parent.get_gravity().y
		hold_frames = MAX_HOLD_FRAMES + 1 
			
		
	
	parent.velocity.y += gravity * delta
	
	
	parent.move_and_slide()
	
	if parent.velocity.y > 0:
		return parent.state_machine.states["fall"]
	
	return null
	
	

	
