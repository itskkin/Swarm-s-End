extends Pickups
class_name Orb

#To store Experience points
@export var XP : float
#activating Orb will make the wizzard gain XP
func activate():
	super.activate()
	print("+" + str(XP) + "XP")
	#implementing gain_XP(amount)function to wizzard
	player_reference.gain_EXP(XP) 
	
