extends Skill
class_name Ultimate
var damage : float = 500.0
func _init(target):
	cooldown = 7.0
	texture = preload("res://Assets/skill-texture/48x48/skill_icons13.png")
	animation_name = "Ultimate"
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.radial(18, damage)
