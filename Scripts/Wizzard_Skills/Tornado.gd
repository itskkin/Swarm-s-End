extends Skill
class_name Tornado
var damage : float = 400.0
func _init(target):
	cooldown = 4.0
	texture = preload("res://Assets/skill-texture/48x48/skill_icons24.png")
	animation_name = "Tornado"
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.single_shot(animation_name, damage)
