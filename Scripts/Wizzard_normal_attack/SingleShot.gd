extends Weapon
class_name SingleShot


func shoot(source, target, scene_tree):
	if target == null or scene_tree.paused == true:
		return
		
	SoundManager.play_sfx(sound)
	#instantiate the projetile node 
	var projectile = projectile_node.instantiate()
	
	#set properties of the projectile with the reasource data 
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position).normalized()
	
	#adding it to the scene tree
	scene_tree.current_scene.add_child(projectile)

#Override the activate function & call shoot
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)
	

#fucntion to upgrade item first check if any upgrade is available or not
func upgrade_item():
	if not is_upgradable():
		return
	
	#if upgradable pick current upgrade 
	var upgrade = upgrades[level - 1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	
	#since this is based Resource just upgrade the common stats
	level +=1
