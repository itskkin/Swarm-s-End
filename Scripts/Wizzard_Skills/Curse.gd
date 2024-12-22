extends Skill
class_name Curse
var damage : float = 400.0
func _init(target):
	cooldown = 0.5
	texture = preload("res://Assets/skill-texture/48x48/skill_icons28.png")
	animation_name = "curse"
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(4, 0.2, animation_name, damage)
