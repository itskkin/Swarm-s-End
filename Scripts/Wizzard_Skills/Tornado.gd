extends Skill
class_name Tornado
var damage : float = 20
func _init(target):
	cooldown = 3.5
	texture = preload("res://Assets/skill-texture/Icons/tile009.png")
	animation_name = "Tornado"
	super._init(target)

func cast_spell(target):
	super.cast_spell(target)
	target.single_shot(animation_name, damage)
