extends Skill
class_name FireShot

var damage : float = 100.0
func _init(target):
	cooldown = 1.5
	animation_name = "fire"
	texture = preload("res://Assets/skill-texture/48x48/skill_icons3.png")
	super._init(target)
	
	#in cast_spell extenteding the parents func and call multi shot
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(3, 0.3, animation_name, damage)
