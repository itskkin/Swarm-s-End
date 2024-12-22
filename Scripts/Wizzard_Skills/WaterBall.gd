extends Skill
class_name WaterBall
var damage : float = 200.0
func _init(target):
	cooldown = 10.0
	animation_name = "water"
	texture = preload("res://Assets/skill-texture/48x48/skill_icons48.png")
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(2, 0.4, animation_name, damage)
