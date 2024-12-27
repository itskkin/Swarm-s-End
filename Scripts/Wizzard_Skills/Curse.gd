extends Skill
class_name Wind
var damage : float = 7.0
func _init(target):
	cooldown = 0.5
	texture = preload("res://Assets/skill-texture/Icons/tile003.png")
	animation_name = "wind"
	super._init(target)
func cast_spell(target):
	super.cast_spell(target)
	target.multi_shot(4, 0.2, animation_name, damage)
