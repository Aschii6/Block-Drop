extends Node2D

@onready var drop_spawn_timer: Timer = $DropSpawnTimer
@onready var player_1: Player = $Player1
@onready var player_2: Player = $Player2
@onready var player_one_score: Label = $Control/MarginContainer/PlayerOneScore
@onready var player_two_score: Label = $Control/MarginContainer/PlayerTwoScore

const BEER = preload("res://scenes/drops/beer/beer.tscn")
const WINE = preload("res://scenes/drops/wine/wine.tscn")
const BOOK = preload("res://scenes/drops/book/book.tscn")

var player_one_points: int = 0
var player_two_points: int = 0

func _ready() -> void:
	drop_spawn_timer.timeout.connect(func():
		var random_number: int = randi_range(0, 2)
		var drop: Drop
		
		if random_number == 0:
			drop = BEER.instantiate()
		elif random_number == 1:
			drop = WINE.instantiate()
		else:
			drop = BOOK.instantiate()
		
		drop.position = Vector2(randf_range(100, 1500), randf_range(-50, 30))
		drop.speed = randf_range(150, 450)
		
		add_child(drop)
	)
	
	Events.drop_touched.connect(func(player_number, points):
		if (player_number == 1):
			player_one_points = max(0, player_one_points + points)
			player_one_score.text = "Player1: " + str(player_one_points)
			player_1.drop_touched.emit(points)
		elif (player_number == 2):
			player_two_points = max(0, player_two_points + points)
			player_two_score.text = "Player2: " + str(player_two_points)
			player_2.drop_touched.emit(points)
	)


func _process(delta: float) -> void:
	pass
