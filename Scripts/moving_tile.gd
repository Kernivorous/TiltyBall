extends MeshInstance3D

@export var point_a : Node3D
@export var point_b : Node3D
@export var move_speed : float = 4.0

func _ready() -> void:
	start_tween_loop()

func start_tween_loop() -> void:

	var tween = get_tree().create_tween()
	tween.set_loops().set_parallel(false)
	tween.tween_property(self, "position", point_b.global_position, move_speed)
	tween.tween_property(self, "position", point_a.global_position, move_speed)
