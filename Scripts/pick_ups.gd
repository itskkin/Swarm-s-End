extends Area2D

var direction : Vector2
var speed : float = 175

@export var type : Pickups
#wizzard will also updating the pickups player resource
@export var player_reference : CharacterBody2D:
	set(value):
		player_reference = value
		type.player_reference = value
		
var can_follow : bool = false

#update the texture for the Sprite2D when the node is ready
func _ready() -> void:
	$Sprite2D.texture = type.icon
	

func _physics_process(delta):
	#when in range Pickups will be moving towards Player
	if player_reference and can_follow:
		direction = (player_reference.position - position).normalized()
		position += direction * speed  * delta
#function follow will set the flag to true	
func follow(_target : CharacterBody2D):
	can_follow = true 

#upon interaction will activate PickupResource and free it from memory
func _on_body_entered(_body: Node2D) -> void:
	type.activate()
	queue_free()
