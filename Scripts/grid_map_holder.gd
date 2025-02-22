extends Node3D

@export var gridmap_controller : Node3D
@export var ball : Player

var levels : Array
var level_one = load("res://Scenes/Levels/level_one.tscn")
var level_two = load("res://Scenes/Levels/level_two.tscn")
var level_three = load("res://Scenes/Levels/level_three.tscn")
var level_four = load("res://Scenes/Levels/level_four.tscn")
var level_five = load("res://Scenes/Levels/level_five.tscn")
var level_six = load("res://Scenes/Levels/level_six.tscn")
var level_seven = load("res://Scenes/Levels/level_seven.tscn")
var level_eight = load("res://Scenes/Levels/level_eight.tscn")

var current_level
var goal
var player_start : Node3D

func _init() -> void:
	levels.append(level_one)
	levels.append(level_two)
	levels.append(level_three)
	levels.append(level_four)
	levels.append(level_five)
	levels.append(level_six)
	levels.append(level_seven)
	levels.append(level_eight)
	
func _ready() -> void:
	Global.current_level = 7
	ball.player_died.connect(on_player_died)
	
	current_level = levels[Global.current_level].instantiate()
	gridmap_controller.add_child(current_level)

	goal = current_level.goal
	goal.completed_level.connect(on_completed_level)
	
	player_start = current_level.player_start
	ball.position = player_start.position
	
	gridmap_controller.active = true

	
func on_player_died() -> void:
	gridmap_controller.reset_rotation()
	ball.position = player_start.position
	ball.reset_velocity()	


func on_completed_level() -> void:
	gridmap_controller.active = false
	ball.deactivate()
	await get_tree().create_timer(3.0).timeout
	next_level_setup()
	

func next_level_setup() -> void:
	
	Global.current_level += 1
	current_level.queue_free()
	
	gridmap_controller.reset_rotation()
	
	current_level = levels[Global.current_level].instantiate()
	gridmap_controller.add_child(current_level)
	
	goal = current_level.goal
	goal.completed_level.connect(on_completed_level)
	
	player_start = current_level.player_start
	
	ball.position = player_start.position
	ball.reset_velocity()
	ball.activate()
	
	gridmap_controller.active = true
	
