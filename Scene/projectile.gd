extends Area2D

@export var speed: float = 200 
var direction: Vector2 = Vector2.RIGHT:
	set(value):
		direction = value
		if $AnimatedSprite2D.animation != "Tornado":
			rotation = direction.angle()


var damage: float = 100.0
#motion of the spells
func _physics_process(delta):
	position += speed * direction * delta

func play(animation_name: String):
	$AnimatedSprite2D.play(animation_name)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		body.knockback += direction * 75
	else:
		print("way damage weak")
