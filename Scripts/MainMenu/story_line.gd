extends Control

var dialog = [
	"Arkanos, a masterful mage and protector of the realm, had long dedicated his life to maintaining the delicate balance between magic and the natural order. One fateful evening, after performing an exhausting ritual to strengthen the magical barriers protecting his city, he fell into a deep sleep in his study. But when he awakens, he is no longer in his familiar surroundings. Instead, he finds himself in a serene yet strange clearing. The area is lush with vibrant green grass and ancient trees, their branches reaching skyward as if guarding this forgotten place. Scattered throughout the clearing are enigmatic statues, a moss-covered stone chair, and an old, weathered tablet carved with indecipherable runes. At the center of it all stands a glowing portal, swirling with ethereal energy.There are no people, no voices, no signs of his world’s bustling life. The only sounds are the rustling leaves and the faint hum of the portal. Arkanos must unravel where he is, why he’s here, and what happened to his civilization.",
]

var dialog_index = 0

func _ready():
	load_dialog()
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()
		
func load_dialog():
	if dialog_index < dialog.size():
		$NinePatchRect/RichTextLabel.bbcode_text = dialog[dialog_index]
		$NinePatchRect/RichTextLabel.visible_ratio = 0

		# Create a tween dynamically
		var tween = create_tween()
		tween.tween_property(
			$NinePatchRect/RichTextLabel, "visible_ratio", 1, 10.0
		)
	else:
		queue_free()
	dialog_index += 1
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/lobby.tscn")
