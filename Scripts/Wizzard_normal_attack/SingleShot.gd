extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree):
	if target == null:
		return
		
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
