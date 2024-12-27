extends PanelContainer

#setter variable to store weapon
@export var weapon : Weapon:
	set(value):
		weapon =  value
		#it will be updateing TextureRect @ wait time for the timer
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown

func _on_cooldown_timeout() -> void:
	if weapon:
		#any upgrade/level up will update the wait time of the timer(coolown)
		$Cooldown.wait_time = weapon.cooldown
		#Each timeout call activate from Weapon
		weapon.activate(owner, owner.nearest_enemy, get_tree())
