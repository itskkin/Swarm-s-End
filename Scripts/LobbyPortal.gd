extends Area2D

@export var start_level = preload("res://Scene/world.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Wizzard":
		# Use call_deferred to avoid changing the scene during a physics callback
		call_deferred("_change_scene")

func _change_scene() -> void:
	if start_level != null:
		get_tree().change_scene_to_packed(start_level)
	else:
		print("Error: start_level is not set")
