extends State

func enter() -> void:
	parent.Animation_Player.play("idle")
	print("Entering Idle State")
	
func exit() -> void:
	parent.Animation_Player.stop()
	print("Exiting Idle State")


func process_physics(delta: float) -> State:
	var move := Input.get_action_strength("Right") - Input.get_action_strength("Left")

	if Input.is_action_just_pressed("Jump"):
		return parent.state_machine.states["jump"]
	
	if move != 0:
		return parent.state_machine.states["walk"]
	if !parent.is_on_floor():
		return parent.state_machine.states["fall"]
	
	return null		
