extends Node2D


@export var player : CharacterBody2D
@export var enemy : PackedScene

var distance : float = 400 

#variable for spawning
var can_spawn : bool = true
#Store array of Enemies
@export var enemy_types : Array[Enemy]


var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)
		
var second : int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute += 1
		%Second.text = str(second).lpad(2,'0')

#spawner will only spawn mobs when the total mobs are below 700
func _physics_process(_delta):
	if get_tree().get_node_count_in_group("Enemy") < 100:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos: Vector2, elite : bool = false):
	#flag control spawns
	if not can_spawn and not elite:
		return
		
	var enemy_instance = enemy.instantiate()
	
	#each minute will be a different wave of enemy
	var random_type_index = randi() % enemy_types.size()
	enemy_instance.type = enemy_types [random_type_index]
	
	enemy_instance.position = pos
	enemy_instance.player_reference = player
	enemy_instance.elite = elite 
	get_tree().current_scene.add_child(enemy_instance)
	
func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	
#function to spawn multiple enemy at a time
func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())
		
#increment "second" with each timeout and spawn enemies
func _on_timer_timeout() -> void:
	second +=1
	amount(second & 10)
	

#if sample size is enough randomness will create a circle


func _on_pattern_timeout() -> void:
	for i in range(40):
		spawn(get_random_position())


func _on_elite_timeout() -> void:
	spawn(get_random_position(), true)
