extends ARVRController

var _mesh_basis: Basis

signal grabbing
signal releasing

func _ready():
	_mesh_basis = $"Mesh".transform.basis

func _process(delta):
	if is_button_pressed(JOY_VR_GRIP):
		$"Mesh".transform.basis = _mesh_basis.scaled(Vector3(0.5, 0.5, 0.5))
		emit_signal("grabbing")
	else:
		$"Mesh".transform.basis = _mesh_basis
		emit_signal("releasing")
