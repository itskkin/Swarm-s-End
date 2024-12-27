extends Resource
class_name Weapon

@export var title : String
@export var texture : Texture2D

@export var damage : float
@export var cooldown : float
@export var speed : float

@export var projectile_node : PackedScene = preload("res://Scene/shotFire.tscn")
   
@export var upgrades : Array[Upgrade]
@export var sound : AudioStream
var level = 1

func activate(_source, _target, _scence_tree):
	pass 
#check if the item is upgradable
func is_upgradable() -> bool:
	if level <= upgrades.size():
		return true
	return false 

#fucntion to upgrade item first check if any upgrade is available or not
#Overriding the function from weapons to upgrade exclusive stats

func upgrade_item():
	if not is_upgradable():
		return
	
	#if upgradable pick current upgrade 
	var upgrade = upgrades[level - 1]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	
	#since this is based Resource just upgrade the common stats
	level +=1
	
