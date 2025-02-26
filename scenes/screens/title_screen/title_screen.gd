extends Control


func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://scenes/screens/play_screen/play_screen.tscn"))


func _on_quit_button_pressed() -> void:
	get_tree().quit()
