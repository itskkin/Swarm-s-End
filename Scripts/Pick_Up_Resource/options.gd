extends VBoxContainer

@export var skills : HBoxContainer
@export var weapons : HBoxContainer

var OptionSlot = preload("res://Scene/option_slot.tscn")

@export var particles : GPUParticles2D
@export var panel : NinePatchRect
#onready hide the option
func _ready():
	hide()
	particles.hide()
	panel.hide()
	
#close_option that will hide option & resume the scene tree
#this function is gettin called by the option slot
func close_option():
	hide()
	particles.hide()
	panel.hide()
	get_tree().paused = false


func get_availabe_weapon():
	var weapon_resource = []
	#traverse through weapons and store available weapons resource
	for weapon in weapons.get_children():
		if weapon.weapon != null:
			weapon_resource.append(weapon.weapon)
	#return array of weapons
	return weapon_resource
	
func show_option():
	#if there no weapon resource return the show function 
	var weapons_available = get_availabe_weapon()
	if weapons_available.size() == 0:
		return
	#if there is any weapon, then remove previous options
	for slot in get_children():
		slot.queue_free()
	
	var option_size = 0
	for weapon in weapons_available:
		if weapon.is_upgradable():
			#add option for any weapon available
			var option_slot = OptionSlot.instantiate()
			option_slot.weapon = weapon
			add_child(option_slot)
			option_size += 1
	
	#if none of the weapons can be upgraded again, then return the function 
	if option_size == 0:
		return
		
		
	show()  
	particles.show()
	panel.show()
	get_tree().paused = true
