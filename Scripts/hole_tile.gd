extends MeshInstance3D

signal completed_level

@onready var level_complete_particles = $GPUParticles3D
@onready var level_complete_audio = $AudioStreamPlayer3D

func _on_hole_body_entered(body: Node3D) -> void:
	if body.active:
		level_complete_particles.emitting = true
		level_complete_audio.play()
		completed_level.emit()
