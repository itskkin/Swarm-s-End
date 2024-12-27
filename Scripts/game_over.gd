extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

func _on_try_again_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func game_over():
	get_tree().paused = true
	self.show()


func _on_back_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/main_menu.tscn")
