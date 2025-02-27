extends Node2D

@onready var drop_spawn_timer: Timer = $DropSpawnTimer

const BEER = preload("res://scenes/drops/beer/beer.tscn")
const WINE = preload("res://scenes/drops/wine/wine.tscn")
const BOOK = preload("res://scenes/drops/book/book.tscn")

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


func _process(delta: float) -> void:
	pass
