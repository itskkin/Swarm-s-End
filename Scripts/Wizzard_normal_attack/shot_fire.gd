extends Area2D


var direction : Vector2 = Vector2.RIGHT
var speed : float = 200
var damage : float = 1


func _physics_process(delta):
	#projectile will be moving at constant speed and direction 
	position += direction * speed * delta
	

func _on_body_entered(body: Node2D) -> void:
	#call take_damage action if the interacting body has one 
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
