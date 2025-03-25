extends CharacterBody2D
class_name Player 

@onready var Velocity_Label: Label = $Label
@onready var state_machine: StateMachine = $StateMachine
@onready var Animation_Player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var AIR_SPEED = 400
@export var AIR_ACCEL = 25
@export var COYOTE_FRAMES = 15 
@export var GROUND_SPEED = 300
@export var JUMP_STRENGTH = 375
@export var JUMP_BUFFER = 30

var current_coyote_frames = 0

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)    
	
func _physics_process(delta: float) -> void:
	Velocity_Label.text = str(current_coyote_frames)
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
	state_machine.process_frame(delta)
