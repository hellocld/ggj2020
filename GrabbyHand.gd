extends ARVRController

var _mesh_basis: Basis

signal grabbing
signal releasing


func _ready():
	connect("button_pressed", self, "_grab")
	connect("button_release", self, "_release")

func _grab(var btn):
	if btn == JOY_VR_GRIP:
		print("Grabbing")
		emit_signal("grabbing")

func _release(var btn):
	if btn == JOY_VR_GRIP:
		print("Releasing")
		emit_signal("releasing")

func is_grabbing() -> bool:
	return true if is_button_pressed(JOY_VR_GRIP) else false
