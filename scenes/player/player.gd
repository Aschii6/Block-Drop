class_name Player
extends CharacterBody2D

signal drop_touched(points: int)

@export var player_number: int = 1

@onready var timer: Timer = $Timer

@onready var eyes: Sprite2D = $Sprite/Eyes
@onready var thumbs_up: Sprite2D = $Sprite/ThumbsUp
@onready var angry_fists: Node2D = $Sprite/AngryFists

const FACE_NORMAL = preload("res://scenes/player/assets/face_a.png")
const FACE_ANGRY = preload("res://scenes/player/assets/face_g.png")
const FACE_HAPPY = preload("res://scenes/player/assets/face_h.png")

@onready var label: Label = $Sprite/Label

enum State {NORMAL, HAPPY, ANGRY}

const SPEED = 400.0
const JUMP_VELOCITY = -600.0

var jump: String
var left: String
var right: String

var state: State = State.NORMAL

func _ready() -> void:
	var numberString
	if (player_number == 1):
		numberString = "one"
		label.text = "P1"
	else:
		numberString = "two"
		label.text = "P2"
	
	jump = "player_" + numberString + "_jump"
	left = "player_" + numberString + "_left"
	right = "player_" + numberString + "_right"
	
	drop_touched.connect(func(points: int):
		if (points < 0):
			_changeState(State.ANGRY)
		elif (points > 0):
			_changeState(State.HAPPY)
	)
	
	timer.timeout.connect(func():
		_changeState(State.NORMAL)
	)

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

func _changeState(newState: State):
	if (state == State.NORMAL and newState == State.NORMAL):
		return
	elif (state == newState):
		timer.start(1)
	else:
		if (newState == State.HAPPY):
			_switch_to_happy()
			timer.start(1)
		elif (newState == State.ANGRY):
			_switch_to_angry()
			timer.start(1)
		else:
			_switch_to_normal()

func _switch_to_happy():
	state = State.HAPPY
	thumbs_up.visible = true
	angry_fists.visible = false
	eyes.texture = FACE_HAPPY

func _switch_to_angry():
	state = State.ANGRY
	thumbs_up.visible = false
	angry_fists.visible = true
	eyes.texture = FACE_ANGRY

func _switch_to_normal():
	if (state == State.NORMAL):
		return
	
	state = State.NORMAL
	
	thumbs_up.visible = false
	angry_fists.visible = false
	eyes.texture = FACE_NORMAL
