extends Node3D

@export var mouse_sensitivity : float = 0.1

const ROTATION_LIMIT : float = deg_to_rad(15.0)
const TILT_LIMIT : float = deg_to_rad(15.0)

var rotation_input : float
var tilt_input : float
var mouse_rotation : Vector3
var floor_rotation: Vector3

var active : bool = false

func _unhandled_input(event: InputEvent) -> void:
	var mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
	if mouse_input:
		rotation_input = -event.relative.x * mouse_sensitivity
		tilt_input = -event.relative.y * mouse_sensitivity


func update_floor(delta):
	mouse_rotation.x += tilt_input * delta
	mouse_rotation.x = clamp(mouse_rotation.x, -TILT_LIMIT, TILT_LIMIT)
	
	mouse_rotation.z += rotation_input * delta
	mouse_rotation.z = clamp(mouse_rotation.z, -ROTATION_LIMIT, ROTATION_LIMIT)
	
	floor_rotation = Vector3(-mouse_rotation.x, 0, mouse_rotation.z)

	rotation = floor_rotation
	
	rotation_input = 0.0
	tilt_input = 0.0


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_rotation.y = rotation.y


func _physics_process(delta: float) -> void:
	if active:
		update_floor(delta)
	

func reset_rotation() -> void:
	mouse_rotation.x = 0.0
	mouse_rotation.z = 0.0
	
	rotation_input = 0.0
	tilt_input = 0.0
	
	rotation = Vector3.ZERO
