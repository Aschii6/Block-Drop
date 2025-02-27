class_name Drop
extends Node2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var area_2d: Area2D = $Area2D

@export var points: int = 1

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(func():
		queue_free()
		print_debug("Drop Freed")
	)


func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	var player = area.get_parent()
	if player.is_in_group("players"):
		var player_instance: Player = player as Player
		if player_instance:
			print_debug("Touched by player ", player_instance.player_number)
			queue_free()
