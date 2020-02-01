extends MeshInstance

var _default_basis: Basis

func _ready():
	_default_basis = transform.basis
	get_parent().connect("grabbing", self, "_on_grabbing")
	get_parent().connect("releasing", self, "_on_releasing")

func _on_grabbing():
	transform.basis = _default_basis.scaled(Vector3.ONE * 0.5)


func _on_releasing(vel):
	transform.basis = _default_basis
