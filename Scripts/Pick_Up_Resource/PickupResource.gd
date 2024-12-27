extends Resource
class_name Pickups  

#Setting properties
@export var title : String
@export var icon : Texture2D
@export_multiline var description : String
@export var sound : AudioStream

#for player reference
var player_reference : CharacterBody2D

#function to get overriden in concete clases
func activate():
	SoundManager.play_sfx(sound)
	print(title + " pick up.")
