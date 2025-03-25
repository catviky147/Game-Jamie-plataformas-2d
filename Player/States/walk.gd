extends State

var move: int = 0

func enter() -> void:
	parent.Animation_Player.play("run")
	parent.current_coyote_frames = 0
	print("Entered Walk State")
	
func exit() -> void:
	parent.Animation_Player.stop()
	print("Exited Walk State")


func process_physics(delta: float) -> State:
	var move := Input.get_action_strength("Right") - Input.get_action_strength("Left")
	parent.velocity.x = move * parent.GROUND_SPEED
	parent.move_and_slide()
	
	if Input.is_action_just_pressed("Jump"):
		return parent.state_machine.states["jump"]
	
	if move == 0:
		return parent.state_machine.states["idle"]
	if !parent.is_on_floor():
		return parent.state_machine.states["fall"]	

	return null
	
	
