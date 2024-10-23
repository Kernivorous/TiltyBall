class_name Player

extends RigidBody3D

signal player_died

var active : bool = true

@onready var hit_audio = $AudioStreamPlayer3D

func reset_velocity() -> void:
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
func activate() -> void:
	freeze = false
	visible = true
	active = true
	
func deactivate() -> void:
	freeze = true
	visible = false
	active = false
