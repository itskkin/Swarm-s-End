extends Resource
class_name Skill

var cooldown: float
var texture: Texture2D
var animation_name: String

@export var sound : AudioStream

#to configure the spell butoons 
func _init(target):
	target.cooldown.max_value = cooldown
	target.texture_normal = texture
	target.timer.wait_time = cooldown

func cast_spell(target):
	SoundManager.play_sfx(sound)
	print(animation_name + " casted from " + target.name)
