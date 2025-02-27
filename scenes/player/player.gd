class_name Player
extends CharacterBody2D

@export var player_number: int = 1

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

var jump: String
var left: String
var right: String

func _ready() -> void:
	var numberString
	if (player_number == 1):
		numberString = "one"
	else:
		numberString = "two"
		
	jump = "player_" + numberString + "_jump"
	left = "player_" + numberString + "_left"
	right = "player_" + numberString + "_right"

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis(left, right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
