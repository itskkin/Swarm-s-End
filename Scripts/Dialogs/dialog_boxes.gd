extends Control

var dialog = [
	"Hmm... What...",
	"This isn’t my study. Where in the Arcane Codex am I?",
	"These statues… they’re ancient. The craftsmanship predates even the first era of the Magic. How could such relics exist without my knowledge?",
	"Everything here feels untouched by time. No signs of my city, no signs of life… but why do I sense such powerful magic in the air?",
	"(Arkanos notices the swirling red portal at the center of the clearing. Its glow pulses like a heartbeat, drawing his gaze.)",
	"A portal... Stable, yet unguarded? That’s unheard of. This magic isn’t wild—it’s deliberate, controlled. Someone or something created this.",
	"Wait... These runes—they’re not warnings. They’re invitations.",
	"Whoever built this, whatever their purpose, they’ll answer to me. If my people are gone, if my world is lost, this portal holds the key to their fate.",
	"Whatever lies beyond that portal isn’t meant for the faint-hearted. But I am no stranger to danger. If this place chose me, then I’ll face it head-on.",
	"Hmmm..."
]

var dialog_index = 0
var dialog_finished = false  # To track when the dialog sequence finishes

func _ready():
	if not should_show_dialog():
		queue_free()  # Remove dialog if it's not supposed to show
	else:
		load_dialog()

func _process(_delta):
	# Allow advancing only when the current dialog is fully shown
	if Input.is_action_just_pressed("ui_accept") and not dialog_finished:
		advance_dialog()

func load_dialog():
	# Check if there is more dialog to display
	if dialog_index < dialog.size():
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.visible_ratio = 0

		# Animate the text appearance with Tween
		var tween = create_tween()
		tween.tween_property(
			$RichTextLabel, "visible_ratio", 1, 1.0
		)
		tween.finished.connect(_on_dialog_animation_finished)
	else:
		dialog_finished = true

func advance_dialog():
	# Increment dialog index and load the next dialog if available
	if dialog_index < dialog.size():
		dialog_index += 1
		load_dialog()
	else:
		queue_free()  # Remove the dialog system when finished

func _on_dialog_animation_finished():
	# Called when the text animation completes
	dialog_finished = false  # Allow advancing to the next dialog

func should_show_dialog() -> bool:
	# Check the current scene
	var current_scene = get_tree().current_scene
	# Replace "World" with the actual name of your scene
	return current_scene.name != "World"
