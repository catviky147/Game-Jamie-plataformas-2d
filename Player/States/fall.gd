extends State



var start_counting := false
var frames_since_jump := 0

func enter() -> void:
	start_counting = false
	frames_since_jump = 0 
	parent.Animation_Player.play("fall")
	print("Entering Fall State")
	
func exit() -> void:
	parent.Animation_Player.stop()
	print('Exitign Fall State')

func process_physics(delta: float) -> State:
	parent.velocity.y += parent.get_gravity().y * delta
	var move := Input.get_action_strength("Right") - Input.get_action_strength("Left")
	parent.velocity.x = lerp(parent.velocity.x, move * parent.AIR_SPEED, delta * parent.AIR_ACCEL)
	
	if parent.current_coyote_frames <= parent.COYOTE_FRAMES:
	
		parent.current_coyote_frames += 1
	
	parent.move_and_slide()
	
	if Input.is_action_just_pressed("Jump"):
		start_counting = true
		if parent.current_coyote_frames <= parent.COYOTE_FRAMES:
			return parent.state_machine.states["jump"]
		
	if start_counting == true:
		frames_since_jump +=1 
		
	
	if parent.is_on_floor():
		if frames_since_jump <= parent.JUMP_BUFFER and start_counting:
			return parent.state_machine.states["jump"]
		
		if parent.velocity.x != 0:
			return parent.state_machine.states["walk"]
		return parent.state_machine.states["idle"]
	return null
	
