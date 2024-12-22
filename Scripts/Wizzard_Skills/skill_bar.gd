extends HBoxContainer
 
var slots : Array
var skills : Array = [FireShot, WaterBall, Tornado, Curse, Ultimate]
 
func _ready():
	slots = get_children()
	for i in get_child_count():
		slots[i].change_key = str(i+1)
		slots[i].skill = skills[i].new(slots[i])
 
#func _on_input_event(event):
	#if event is InputEventKey and event.pressed:
		#var key = OS.get_scancode_string(event.scancode)
		#for i in range(slots.size()):
			#if key == str(i + 1):  # Match key to slot index
				#active_skill_index = i
				#print("Skill selected: ", skills[i].name)
#
## Function to inflict damage based on active skill
#func inflict_damage_to_enemy(enemy):
	#if active_skill_index != -1 and active_skill_index < skills.size():
		#var skill_instance = skills[active_skill_index].new()
		#var damage = skill_instance.calculate_damage()  # Assuming each skill has a `calculate_damage` method
		#enemy.take_damage(damage)  # Assuming enemy has a `take_damage` method
		#print("Inflicted ", damage, " damage to ", enemy.name)

## Example signal connection to detect body entry (collisions or area triggers)
#func _on_body_entered(body):
	#if body.is_in_group("enemies"):
		#inflict_damage_to_enemy(body)
